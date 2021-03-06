// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract Father {
    event FatherName(string name);

    function who() public virtual {
        emit FatherName("KimDong");
        emit FatherName("LeeDong");
        emit FatherName("ParkDong");
    } // ๐ event๊ฐ ์ฌ๋ฌ๊ฐ ์ผ๊ฒฝ์ฐ
}

contract Son is Father {
    event SonName(string name);

    function who() public override {
        super.who();
        // ๐ super๋ฅผ ์ฐ๋ฉด ์ฌ๋ฌ๊ฐ์ฌ๋ ํ๋ฒ์ ์์๋ฐ์์จ๋ค

        emit SonName("KimJin");
    }
}
