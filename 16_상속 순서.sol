// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract Father {
    event FatherName(string name);

    function who() public virtual {
        emit FatherName("KimJin");
    }
}

contract Mother {
    event MotherName(string name);

    function who() public virtual {
        emit MotherName("LeeSol");
    }
}

contract Son is Father, Mother {
    function who() public override(Father, Mother) {
        super.who(); // ๐ "LeeSol"
        // ๐ Mother์ ์ด๋ฒคํธ๋ง ๊ฐ์ ธ์จ๋ค
    } // ๐ Father, Mother์ค ๋ง์ง๋ง์ ์ค๋ ๊ฑธ ์์๋ฐ๋๋ค
}
