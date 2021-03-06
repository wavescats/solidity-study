// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract Father {
    string public finallyName = "Kim";
    string public givenName = "Jung";
    uint256 public money = 100;

    function getFinallyName() public view returns (string memory) {
        return finallyName;
    } // π 'Kim' μ λ¦¬ν΄νλ€

    function getGivenName() public view returns (string memory) {
        return givenName;
    } // π 'Jung' μ λ¦¬ν΄νλ€

    function getMoney() public view returns (uint256) {
        return money;
    } // π 100 μ λ¦¬ν΄νλ€
}

contract Son is Father {
    // π Son μ΄λΌλ μ»¨νΈλνΈμ is μ μμλ°μ μ»¨νΈλνΈ λͺ
    // π μμ Father μ»¨νΈλνΈλ₯Ό λ€ κ°μ Έμ¨λ€
}
