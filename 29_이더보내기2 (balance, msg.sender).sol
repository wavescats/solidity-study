// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// μ£Όμ.balance λ π ν΄λΉνλ νΉμ μ£Όμμ νμ¬ μ΄λλ¦¬μ μμ‘μ λνλΈλ€
// (msg.value) λ μ‘κΈνκ³ μ νλ μ΄λλ¦¬μ κ°(κ°―μ)

// msg.sender π μ€λ§νΈμ»¨νΈλνΈλ₯Ό μ¬μ©νλ μ£Όμ²΄

//--------------------------------------------

contract Bank {
    event SendInfo(address _msgSender, uint256 _currentValue);
    event MyCurrentValue(address _msgSender, uint256 _value);
    event CurrentValueOfSomeone(
        address _msgSender,
        address _to,
        uint256 _value
    );

    function sendEther(address payable _to) public payable {
        // _toλ 'μ΄λλ¦¬μμ λ°μ μ£Όμ' λ§μ§λ§μλ payableλ₯Ό μ¨μ€μΌνλ€
        require(msg.sender.balance >= msg.value, "not enough");
        // msg.sender.balance λ μ¬μ©μμ μμ‘μ΄ μμλ "not enough"
        // requireλ (false μ΄λ©΄) μλ¬λ₯Ό λ°μμν¨λ€
        _to.transfer(msg.value);
        // μλ¬κ° μλλΌλ©΄ (true μ΄λ©΄)
        // _to π μ΄λλ¦¬μμ λ°μ μ£Όμμ λͺ μ΄λλ₯Ό λ³΄λΌμ§ μλ ₯
        emit SendInfo(msg.sender, (msg.sender).balance);
        // SendInfo μ΄λ²€νΈ μ€ν (μ¬μ©μμ£Όμ, μ¬μ©μμ μμ‘)
    }

    function checkValueNow() public {
        emit MyCurrentValue(msg.sender, msg.sender.balance);
    } // μ¬μ©μμ£Όμ, μ¬μ©μμ μμ‘

    function checkUserMoney(address _to) public {
        emit CurrentValueOfSomeone(msg.sender, _to, _to.balance);
    } // μ¬μ©μμ£Όμ, λ³΄λΌ μ£Όμ, λ³΄λΈ μ£Όμμ μμ‘
}
