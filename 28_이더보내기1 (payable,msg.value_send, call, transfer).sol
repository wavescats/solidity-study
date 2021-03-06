// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// payable ๐ ํ ํฐ ์ํธ์์ฉ ์ ํ์ํ ํค์๋
// ex) ์ด๋๋ฆฌ์์ ์ ์กํ๊ฑฐ๋ ๋ฐ์๋ payable ์ด๋ผ๋ ํค์๋๊ฐ ํ์ํ๋ค
// ์ด๋๋ฆฌ์์ ๋ณด๋ด๋ ํจ์๋ฅผ ๋ง๋ ๋ค๊ณ  ํ์๋ / ๊ทธ ํจ์์๋ payable๋ฅผ ๊ผญ ๋ถ์ฌ์ค์ผํ๋ค
// ๐ payable ์ send / transfer / call ๊ณผ ๊ฐ์ด ์ฌ์ฉ๋๋ค

// msg.value ๐ ์ก๊ธ๋ณด๋ธ ์ฝ์ธ์ ๊ฐ

// 1. send ๐ 2300 gas๋ฅผ ์๋น / ์๋ฌ๋ฅผ ๋ฐ์์ํค์ง ์๊ณ  true ๋๋ false๋ก ๋ฆฌํดํ๋ค
// 2. call ๐ ๊ฐ๋ณ์ ์ธ gas๋ฅผ ์๋น(gas๊ฐ์ ์ง์ ๊ฐ๋ฅ) / ์๋ฌ๋ฅผ ๋ฐ์์ํค์ง ์๊ณ  true ๋๋ false๋ก ๋ฆฌํดํ๋ค
// โญ ์ด๋๋ฆฌ์์ ๊ฐ๊ฒฉ์ด ์ค๋ฅด๋ฉด ๊ฐ๋ณ์ ์ธ gas๊ฐ์ธ call ์ด ํจ์จ์ ์ผ์๊ฐ ์๋ค

// 3. transfer ๐ 2300 gas๋ฅผ ์๋น / ์คํจ์ ์๋ฌ๋ฅผ ๋ฐ์์ํจ๋ค
// โญ ๋ณดํต transfer์ ๋ง์ด ์ด๋ค
//--------------------------------------------

contract payab {
    event howMuch(uint256 _value);

    function sendNow(address payable _to) public payable {
        // _to๋ '์ด๋๋ฆฌ์์ ๋ฐ์ ์ฃผ์' ๋๋ '์ค๋งํธ์ปจํธ๋ํธ ์ฃผ์' ๋ง์ง๋ง์๋ payable๋ฅผ ์จ์ค์ผํ๋ค
        bool sent = _to.send(msg.value); // ๊ฒฐ๊ณผ๋ฅผ true ์ false ๋ก ๋ฐํ์ ํ๋ค
        require(sent, "Failed"); // false ์ผ๋๋ require์ ๋ฐํ
        emit howMuch(msg.value); // true ์ผ๋๋ ์ด๋ฒคํธ๋ฅผ ์คํ
    }

    // โญ msg.value ๐ ์ก๊ธ๋ณด๋ธ ์ฝ์ธ์ ๊ฐ
    //--------------------------------------------
    function transferNow(address payable _to) public payable {
        // _to๋ '์ด๋๋ฆฌ์์ ๋ฐ์ ์ฃผ์' ๋๋ '์ค๋งํธ์ปจํธ๋ํธ ์ฃผ์' ๋ง์ง๋ง์๋ payable๋ฅผ ์จ์ค์ผํ๋ค
        _to.transfer(msg.value);
        // transfer๋ ์๋ฌ๋ฅผ ๋ฐ์ํ ์ ์์ด์ ๋ฐ๋ก ์๋ฌํธ๋ค๋ฌ๋ฅผ ์ถ๊ฐ ํ์ง ์์๋ ๋๋ค
        emit howMuch(msg.value);
    }

    //--------------------------------------------
    function callNow(address payable _to) public payable {
        // ~ 0.7 ๋ฒ์ ์์ ์ฌ์ฉ์
        // (bool sent, ) = _to.call.gas(1000).value(msg.value)("");
        // require(sent, "Failed!");
        //--------------------------------------------
        // 0.7 ~ ๋ฒ์ ์์ ์ฌ์ฉ์
        (bool sent, ) = _to.call{value: msg.value, gas: 1000}("");
        require(sent, "Failed!");
        emit howMuch(msg.value);
    }
}
