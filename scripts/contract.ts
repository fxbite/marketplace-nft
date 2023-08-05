import { ethers } from 'hardhat';
import * as Config from './config'
import dotenv from 'dotenv'
dotenv.config()

export const getContract = async(nameContract: string) => {
    await Config.initConfig()
    const contract = await ethers.getContractAt(nameContract, await Config.getConfig(nameContract))
    return contract
}

