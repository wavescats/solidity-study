// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract Father {
    uint256 public fatherMoney = 100;

    function getFatherName() public pure returns (string memory) {
        return "KimJung";
    } // π 'KimJung' μ λ¦¬ν΄νλ€

    function getMoney() public view virtual returns (uint256) {
        return fatherMoney;
    } // π 100 μ λ¦¬ν΄νλ€
}

contract Mother {
    uint256 public motherMoney = 500;

    function getMotherName() public pure returns (string memory) {
        return "LeeSoo";
    } // π 'LeeSoo' μ λ¦¬ν΄νλ€

    function getMoney() public view virtual returns (uint256) {
        return motherMoney;
    } // π 500 μ λ¦¬ν΄νλ€
}

contract Son is Father, Mother {
    // π Son μ΄λΌλ μ»¨νΈλνΈμ is μ μμλ°μ μ»¨νΈλνΈ λͺ
    // π μμ Fatherμ Mother μ»¨νΈλνΈλ₯Ό λ€ κ°μ Έμ¨λ€

    function getMoney() public view override(Father, Mother) returns (uint256) {
        // π Fatherμ Motherμ λλ€ 'getMoney' ν¨μκ° μμΌλκΉ 'override' μ μ΄μ©ν΄ λκ° λ€ μμλ°μμ¬μ μλ€
        return fatherMoney + motherMoney;
    } // π 100 + 500
}
