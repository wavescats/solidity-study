// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

interface ERC20Interface {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function transferFrom(
        address spender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Transfer(
        address indexed spender,
        address indexed from,
        address indexed to,
        uint256 amount
    );
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 oldAmount,
        uint256 amount
    );
}

//----------------------------------------------------------------

library SafeMath {
    // π κΈ°μ‘΄ ERC-20 μ½λμμ SafeMath λΌμ΄λΈλ¬λ¦¬λ₯Ό μΆκ°
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a / b;
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

// 'internal'μ ν¨μκ° μ»¨νΈλνΈ λ΄λΆμμλ§ μ¬μ©λ  μ μλλ‘ μ νν  λ μ¬μ©νλ€
// 'pure' λ ν¨μκ° μν λ³μλ₯Ό μ½κ±°λ μ°μ§ μμ λ μ¬μ©νλ€
// 'SafeMath' λΌμ΄λΈλ¬λ¦¬μ ν¨μμμλ λ¨μ μ°μ°μ κ²°κ³Όκ°μ λ°ννκΈ° λλ¬Έμ μν λ³μλ₯Ό μ½κ±°λ μ°μ§ μλλ€
// β­ 'assert'λ falseλ₯Ό λ¦¬ν΄νμ§λ§ κ³μ½μ μ€ν μν€κΈ° μ μ νμΈμ ν  μ μκ³ ,
// β­ 'require'λ κ³μ½μ μ€ν μν€κΈ° μ μ νμΈμ ν  μ μλκ²μΌλ‘ μ μ μλ€

//----------------------------------------------------------------
abstract contract OwnerHelper {
    // π 'OwnerHelper' μ»¨νΈλνΈλ 'abstract contract'λΌκ³  νλ μΆμ μ»¨νΈλνΈ
    // abstract contractλ contractμ κ΅¬νλ κΈ°λ₯κ³Ό interfaceμ μΆμν κΈ°λ₯ λͺ¨λλ₯Ό ν¬ν¨νλ€
    // abstract contractλ λ§μ½ μ€μ  contractμμ μ¬μ©νμ§ μλλ€λ©΄ μΆμμΌλ‘ νμλμ΄ μ¬μ©λμ§ μλλ€
    address private _owner;
    // π _ownerλ κ΄λ¦¬μλ₯Ό λνλ

    event OwnershipTransferred(
        address indexed preOwner,
        address indexed nextOwner
    );
    // π 'OwnershipTransferred' μ΄λ²€νΈλ κ΄λ¦¬μκ° λ³κ²½λμμλ μ΄μ  κ΄λ¦¬μμ μ£Όμμ μλ‘μ΄ κ΄λ¦¬μμ μ£Όμ λ‘κ·Έλ₯Ό λ¨κΈ΄λ€

    modifier onlyOwner() {
        require(msg.sender == _owner, "OwnerHelper: caller is not owner");
        _;
    }

    // π 'onlyOwner' ν¨μ λ³κ²½μλ ν¨μ μ€ν μ΄μ μ ν¨μλ₯Ό μ€νμν€λ μ¬λμ΄ κ΄λ¦¬μμΈμ§ νμΈνλ€

    constructor() {
        _owner = msg.sender;
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != _owner);
        require(newOwner != address(0x0));
        address preOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(preOwner, newOwner);
    }
}

//----------------------------------------------------------------

contract SimpleToken is ERC20Interface, OwnerHelper {
    using SafeMath for uint256;
    // π λ©μΈ μ»¨νΈλνΈμΈ SimpleTokenμμλ μλ£ν 'uint256'μ λν΄μ 'SafeMath' λΌμ΄λΈλ¬λ¦¬λ₯Ό μ¬μ©νλλ‘ μ μΈν΄μ€λ€
    // 'uint256'μΌλ‘ μ μΈλ ν¨μμ λν΄μ 'SafeMath Library'λ₯Ό μ΄μ©ν΄μ 'transferFrom'κ³Ό '_transfer' ν¨μλ₯Ό μ¬μ©μ ν  μ μλ€

    // 'transferFrom'κ³Ό '_transfer'μμ μ¬μ©λλ μ°μ°μ(+, -)λ₯Ό 'SafeMath' λΌμ΄λΈλ¬λ¦¬ ν¨μλ₯Ό μ¬μ©ν΄ μμ ν μ°μ°μλ‘ λ³κ²½ν  μ μμ

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) public _allowances;

    uint256 public _totalSupply;
    string public _name;
    string public _symbol;
    uint8 public _decimals;
    bool public _tokenLock;
    mapping(address => bool) public _personalTokenLock;

    constructor(string memory getName, string memory getSymbol) {
        _name = getName;
        _symbol = getSymbol;
        _decimals = 18;
        _totalSupply = 100000000e18;
        _balances[msg.sender] = _totalSupply;
        _tokenLock = true;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() external view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account)
        external
        view
        virtual
        override
        returns (uint256)
    {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        _transfer(msg.sender, recipient, amount);
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender)
        external
        view
        override
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount)
        external
        virtual
        override
        returns (bool)
    {
        // uint256 currentAllownace = _allowances[spender][msg.sender];  // μ­μ 
        uint256 currentAllowance = _allowances[msg.sender][spender]; // μΆκ°
        require(
            _balances[msg.sender] >= amount,
            "ERC20: The amount to be transferred exceeds the amount of tokens held by the owner."
        );
        _approve(msg.sender, spender, currentAllowance, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        emit Transfer(msg.sender, sender, recipient, amount);
        uint256 currentAllowance = _allowances[sender][msg.sender];
        require(
            currentAllowance >= amount,
            "ERC20: transfer amount exceeds allowance"
        );
        // λ€μμ μ½λμμ currentAllowance.sub(amount)μ΄ SafeMath λΌμ΄λΈλ¬λ¦¬ ν¨μλ₯Ό μ¬μ©ν μμ
        _approve(
            sender,
            msg.sender,
            currentAllowance,
            currentAllowance - amount
        );
        return true;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(
            isTokenLock(sender, recipient) == false,
            "TokenLock: invalid token transfer"
        );
        uint256 senderBalance = _balances[sender];
        require(
            senderBalance >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        _balances[sender] = senderBalance.sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
    }

    // uint256 μΌλ‘ μ μΈνλ 'currentAllowance'μ 'senderBalance'μ 'sub' ν¨μλ₯Ό μ¬μ© κ°λ₯ν λͺ¨μ΅μ λ³Ό μ μλ€
    // 'Mapping' μΌλ‘ μ μΈνλ '_balances' λ uint256 μΌλ‘ λ°μμ€λ κ°μμ add ν¨μλ₯Ό μ¬μ© κ°λ₯νλ€

    // π '_transfer'μ κ²μ¬λ₯Ό μΆκ°ν΄, λ³΄λ΄λ μ¬λκ³Ό λ°λ μ¬λ μ€ λ½μ΄ κ±Έλ €μλ€λ©΄ ν ν°μ μ΄λμ΄ λΆκ°λ₯νλ€

    function isTokenLock(address from, address to)
        public
        view
        returns (bool lock)
    {
        // π ν¨μ 'isTokenLock' μ μ μ²΄ λ½κ³Ό, λ³΄λ΄λ μ¬λμ λ½, λ°λ μ¬λμ λ½μ κ²μ¬νμ¬ λ½μ΄ κ±Έλ € μλμ§ νμΈνλ€
        lock = false;

        if (_tokenLock == true) {
            lock = true;
        }

        if (
            _personalTokenLock[from] == true || _personalTokenLock[to] == true
        ) {
            lock = true;
        }
    }

    // 'tokenLock' μ ν ν°μ μ μ²΄ λ½μ λν μ²λ¦¬, 'tokenPersonalLock' μ ν ν°μ κ°μΈ λ½μ λν μ²λ¦¬μ΄λ€

    // λ€μμ μ½λμμ ν¨μλ‘ μ λ¬λλ νλΌλ―Έν° λΈλΌμΌ λ€μ μ€λ onlyOwnerκ° μμμ΄λ€
    function removeTokenLock() public onlyOwner {
        require(_tokenLock == true);
        _tokenLock = false;
    }

    // λ½λ€μ μ κ±° ν  μ μλ removeTokenLock

    // λ€μμ μ½λμμ ν¨μλ‘ μ λ¬λλ νλΌλ―Έν° λΈλΌμΌ λ€μ μ€λ onlyOwnerκ° μμμ΄λ€
    function removePersonalTokenLock(address _who) public onlyOwner {
        require(_personalTokenLock[_who] == true);
        _personalTokenLock[_who] = false;
    }

    // λ½λ€μ μ κ±° ν  μ μλ removePersonalTokenLock
    // μ΄ ν¨μλ€μ 'onlyOwner'λ₯Ό μ μ©νμ¬ κ΄λ¦¬μλ§ λ½μ ν΄μ ν  μ μλλ‘ ν΄μΌ νλ€
    // μ΄λ κ² λ½μ μ μ©νκ² λλ©΄ λͺ¨λ  λ½μ ν΄μ ν  λλ§ ν ν°μ μ΄λμ΄ κ°λ₯νλ€

    function _approve(
        address owner,
        address spender,
        uint256 currentAmount,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        require(
            currentAmount == _allowances[owner][spender],
            "ERC20: invalid currentAmount"
        );
        _allowances[owner][spender] = amount; // μ­μ 
        emit Approval(owner, spender, currentAmount, amount);
    }
}
