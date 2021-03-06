// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// fallback π λλΉμ± ν¨μ
// 1. μ΄λ¦μ΄ μλ ν¨μ μ΄λ€ (λ¬΄κΈ°λͺ ν¨μ)
// 2. external μ νμλ‘ μ¬μ©ν΄μΌνλ€
// 3. payable μ κΌ­ λΆμ¬μ μ¬μ©ν΄μΌνλ€

// π μ€λ§νΈμ»¨νΈλνΈκ° μ΄λλ¦¬μμ λ°μμ μκ² νλ€
// π μ΄λλ¦¬μμ λ°κ³  λ ν μ΄λ ν νλμ μ·¨νκ² ν  μ μλ€
// π call ν¨μλ‘ μλ ν¨μκ° λΆλ €μ§λ, μ΄λ ν νλμ μ·¨νκ² ν  μ μλ€
//--------------------------------------------
/*
β­ ~ 0.6 λ²μ μμ μ¬μ©λ²
function() external payable { }

//--------------------------------------------
β­ 0.6 ~ λ²μ μμ μ¬μ©λ²

0.6 μ΄νμμλ fallback κ³Ό recevie λ‘ λκ°μ§λ‘ λλλ€

recevie π μμνκ² μ΄λλ¦¬μλ§ λ°μλ μλ
fallback π ν¨μλ₯Ό μ€ννλ©΄μ μ΄λλ¦¬μμ λ³΄λΌλ, λΆλ €μ§ ν¨μκ° μμλ μλ
//--------------------------------------------
fallback() external { }

fallback() external payable { }
// π μ΄λλ¦¬μμ λ°μμλ μκ³  fallback ν¨μλ μλλλ€

recevie() external payable { }

*/

contract Bank {
    event Funds(address _from, uint256 _value, string message);

    function() external payable {
        emit Funds(msg.sender, msg.value, "Funds is called");
    } // μ¬μ©μμ£Όμ, λ³΄λΌ κΈμ‘, λ©μΈμ§
}

//--------------------------------------------
contract You {
    function DepositSend(address payable _to) public payable {
        bool success = _to.send(msg.value);
        require(success, "Failed!");
    }

    //--------------------------------------------
    function DepositTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    //--------------------------------------------
    // ~ 0.7 λ²μ 
    function DepositCall(address payable _to) public payable {
        (bool sent, ) = _to.call.value(msg.value)("");
        require(sent, "Failed!");
    }

    //--------------------------------------------
    // ~ 0.7 λ²μ 
    function JustMessage(address _to) public {
        (bool sent, ) = _to.call("HI");
        require(sent, "Failed!");
    }

    //--------------------------------------------
    // ~ 0.7 λ²μ 
    function JustFunds(address payable _to) public payable {
        (bool sent, ) = _to.call.value(msg.value)("HI");
        require(sent, "Failed");
    }
}
