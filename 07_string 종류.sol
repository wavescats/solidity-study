// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// string μ’λ₯

// storage  π λλΆλΆμ λ³μ / ν¨μ λ€μ΄ μμμ μΌλ‘ μ μ₯λλ€ / κ°μ€λΉμ©μ΄ λΉμΈλ€
// memory   π ν¨μμ νλΌλ―Έν° / λ¦¬ν΄κ° / λ νΌλ°μ€ νμμ΄ μ μ₯λλ€
//              μμμ μΌλ‘ μ μ₯λμ§λ μκ³  / ν¨μ λ΄μμλ§ μ ν¨νλ€ / κ°μ€λΉμ©μ΄ μΈλ€

// colldata π μ£Όλ‘ external function μ νλΌλ―Έν°μμ μ¬μ©λλ€
// stack    π EVM μμ stack dataλ₯Ό κ΄λ¦¬ν λ μ°λ μμ­ / 1024Mb μ ν
//--------------------------------------------

contract str {
    function getstr(string memory str1) public pure returns (string memory) {
        return str1;
    }

    //--------------------------------------------

    function getuint(uint256 ui) public pure returns (uint256) {
        return ui;
    }
    //function getuint(uint256 memory ui) public pure returns (uint256 memory) {
    //  return ui;
    //} π data νμμ memoryκ° κΈ°λ³Έκ°μΌλ‘ λ€μ΄κ° μκΈ° λλ¬Έμ memoryλ₯Ό μλ΅νλ€
}
