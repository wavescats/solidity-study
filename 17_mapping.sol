// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// mapping
// π key κ°μ λ£μ΄μ£Όλ©΄ κ·Έμ λμλλ valueκ°μ μ»κ² ν΄μ£Όλκ²
//--------------------------------------------

contract mapp {
    mapping(uint256 => uint256) private ageList;
    mapping(string => uint256) private priceList;
    mapping(uint256 => string) private nameList;

    // ν€κ°μ νμ => λ°Έλ₯κ°μ νμ  / μ κ·Όμ νμ / mapping μ΄λ¦

    function setAgeList(uint256 _index, uint256 _age) public {
        // μλ²λ²νΈ(μ«μ)μ λμ΄(μ«μ)λ₯Ό λ§€μΉ­(μν), μ§μ  μμΌμ£Όλ ν¨μ
        ageList[_index] = _age;
        // π ex) 3λ² = 23μ΄
    }

    function getAge(uint256 _index) public view returns (uint256) {
        // μλ²λ²νΈ(μ«μ)λ₯Ό μ μΌλ©΄ λμ΄(μ«μ)κ° λ¦¬ν΄λλ ν¨μ
        return ageList[_index];
        // π ex) 3λ²μ μ μΌλ©΄ 23 μ΄ λμ¨λ€(λ¦¬ν΄λλ€)
    }

    //--------------------------------------------
    function setNameList(uint256 _index, string memory _name) public {
        // μλ²λ²νΈμ μ΄λ¦μ λ§€μΉ­(μν), μ§μ  μμΌμ£Όλ ν¨μ
        nameList[_index] = _name;
        // π ex) 2λ² = μ² μ
    }

    function getName(uint256 _index) public view returns (string memory) {
        // μλ²λ²νΈ(μ«μ)λ₯Ό μ μΌλ©΄ μ΄λ¦(string)μ΄ λ¦¬ν΄λλ ν¨μ
        return nameList[_index];
        // π ex) 2λ²μ μ μΌλ©΄ μ² μκ° λμ¨λ€(λ¦¬ν΄λλ€)
    }

    //--------------------------------------------
    function setPriceList(string memory _itemName, uint256 _price) public {
        // item μ΄λ¦κ³Ό κ°κ²©μ λ§€μΉ­(μν), μ§μ  μμΌμ£Όλ ν¨μ
        priceList[_itemName] = _price;
        // π ex) λΈκΈ° = 1,000μ / μΌλ‘ μ§μ νλ€
    }

    function getPriceList(string memory _index) public view returns (uint256) {
        // item μ΄λ¦(string)μ μ μΌλ©΄ κ°κ²©(μ«μ)μ΄ λ¦¬ν΄λλ(λμ€λ) ν¨μ
        return priceList[_index];
        // π ex) λΈκΈ°λ₯Ό μ μΌλ©΄ 1,000 μ΄ λμ¨λ€(λ¦¬ν΄λλ€)
    }
}
