// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// enum π μ¬λμ΄ μ½μ μ μκ², κ°λ°μμ μν΄ μ μλ μμ μΈνΈ 0 ~ 255 κΉμ§μ μμ
// enum μ΄λ¦λͺ { }

//--------------------------------------------

contract nums {
    enum CarStatus {
        TurnOff,
        TurnOn,
        Driving,
        Stop
    }

    CarStatus public car; // car λΌλ λ³μλ₯Ό νλ μμ±

    constructor() {
        car = CarStatus.TurnOff;
    } // λ§¨μ²μ μλμ°¨μ μνλ TurnOff

    event carCurrentStatus(CarStatus _car, uint256 _carInt);

    function turnOnCar() public {
        require(car == CarStatus.TurnOff, "Off!");
        // μλμ°¨μ μνκ° TurnOffμΌλ "Off!"
        // requireλ (false μ΄λ©΄) μλ¬λ₯Ό λ°μμν¨λ€
        car = CarStatus.TurnOn;
        // true μν(μλ) μΌλλ TurnOn
        emit carCurrentStatus(car, uint256(car));
    }
}
