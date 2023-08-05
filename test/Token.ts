import { ethers } from 'hardhat'
import { Contract } from 'ethers'
import { expect } from 'chai'
import { getContract } from '../scripts/contract'

describe('ERC20 Token Contract', () => {
    let tokenContract: Contract
    let ownerAddress: string 

    beforeEach(async () => {
        const metalToken = await getContract('MetalToken')
        const signers = await ethers.getSigners()
        ownerAddress = await signers[0].getAddress()
        tokenContract = metalToken
    });

    it('Deployment', async () => {
        expect(await tokenContract.owner()).to.equal(ownerAddress);
        console.log('Total supply: ', await tokenContract.totalSupply());
    });

    // describe('Transactions', function () {
    //     it('Transfer 20000000000 tokens from owner to addres recipient', async function () {
    //         console.log("owner: ", ownerAddress);
    //         console.log("addres_recipient: ", addres_recipient);
    //         console.log("before transfer");
    //         console.log("owner balance: ", await wibuToken.balanceOf(owner.address));
    //         console.log(
    //         "addres_recipient balance: ",
    //         await wibuToken.balanceOf(addres_recipient)
    //         );
    //         await wibuToken.transfer(addres_recipient, 20000000000);
    
    //         console.log("after transfer");
    //         console.log("owner balance: ", await wibuToken.balanceOf(owner.address));
    //         console.log(
    //         "addr1 balance: ",
    //         await wibuToken.balanceOf(addres_recipient)
    //         );
    //     });
    // });
});

