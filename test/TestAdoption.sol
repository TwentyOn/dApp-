// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.0 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
    // Адрес контракта adoption, который необходимо протестировать
    Adoption adoption = Adoption(DeployedAddresses.Adoption());

    // Идентификатор карточки животного, которое будет использоваться для тестирования
    uint256 expectedPetId = 8;

    // Тестирование функции adopt()
    function testUserCanAdoptPet() public {
        uint256 returnedId = adoption.adopt(expectedPetId);

        Assert.equal(
            returnedId,
            expectedPetId,
            "Adoption of the expected pet should match what is returned."
        );
    }

    // Проверка владельца одного животного
    function testGetAdopterAddressByPetId() public {
        address adopter = adoption.adopters(expectedPetId);

        Assert.equal(
            adopter,
            expectedAdopter,
            "Owner of the expected pet should be this contract"
        );
    }

    // Тест владельца всех животных
    function testGetAdopterAddressByPetIdInArray() public {
        // Store adopters in memory rather than contract's storage
        address[16] memory adopters = adoption.getAdopters();

        Assert.equal(
            adopters[expectedPetId],
            expectedAdopter,
            "Owner of the expected pet should be this contract"
        );
    }

    // The expected owner of adopted pet is this contract
    address expectedAdopter = address(this);
}
