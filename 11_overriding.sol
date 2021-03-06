// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract Father {
    uint256 public money = 100;

    function getMoney() public view virtual returns (uint256) {
        return money; // π λΆλͺ¨μλ 'virtual' μ λͺμν΄μ€λ€
    } // π 100 μ λ¦¬ν΄νλ€
}

contract Son is Father {
    // π Son μ΄λΌλ μ»¨νΈλνΈμ is μ μμλ°μ μ»¨νΈλνΈ λͺ
    // π μμ Father μ»¨νΈλνΈλ₯Ό λ€ κ°μ Έμ¨λ€

    uint256 public earning = 0;

    function work() public {
        earning += 100;
    } // π work ν¨μλ₯Ό μ€ν ν λλ§λ€ 100μ© μ¦κ°

    function getMoney() public view override returns (uint256) {
        return money + earning; // π μμλ°μμ¬ 'override' μ λͺμν΄μ€λ€
    } // π κΈ°μ‘΄ μ μλ money 100 μ λ¦¬ν΄νκ³ 
    // π earning 100 μ΄ κ³μ μΆκ°λλ€ (work ν¨μκ° μ€νλ λλ§λ€)
}
