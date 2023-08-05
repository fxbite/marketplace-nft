import { ethers, hardhatArguments } from 'hardhat';
import * as Config from './config';

async function main() {
  await Config.initConfig();
  const network = hardhatArguments.network ? hardhatArguments.network : 'dev';
  const [deployer] = await ethers.getSigners();
  console.log('deploy from address: ', deployer.getAddress());

  // const MetalToken = await ethers.getContractFactory('MetalToken');
  // const metalToken = await MetalToken.deploy();
  // const metalTokenAddress = await metalToken.getAddress()
  // console.log('Metal Token address: ', metalTokenAddress);
  // Config.setConfig(network + '.MetalToken', metalTokenAddress);

  // const WoTNFT = await ethers.getContractFactory('WoTNFT');
  // const wotnft = await WoTNFT.deploy();
  // const wotnftAddress = await wotnft.getAddress()
  // console.log('WoTNFT address: ', wotnftAddress);
  // Config.setConfig(network + '.WoTNFT', wotnftAddress);

  // const MarketPlace = await ethers.getContractFactory('WoTMarketplace');
  // const marketplace = await MarketPlace.deploy(await Config.getConfig('WoTNFT'), await Config.getConfig('MetalToken'));
  // const marketplaceAddress = await marketplace.getAddress()
  // console.log('Market deployed at: ', marketplaceAddress);
  // Config.setConfig(network + '.Marketplace', marketplaceAddress);

  await Config.updateConfig()
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
