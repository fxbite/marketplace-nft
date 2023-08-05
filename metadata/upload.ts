import Moralis from 'moralis';
import fs from 'fs'
import dotenv from 'dotenv'
dotenv.config()

async function uploadImageToIPFS() {
    await Moralis.start({
        apiKey: process.env.MORALIS_API_KEY!,
    });
      
    const uploadArray = [
        // {
        //     path: "event.png",
        //     content: fs.readFileSync('scripts/static/image/Event.png', {encoding: 'base64'})
        // },
        {
            path: "metadata.json",
            content: fs.readFileSync('scripts/static/metadata/metadata.json', {encoding: 'base64'})
        },
    ];

    const response = await Moralis.EvmApi.ipfs.uploadFolder({
    abi: uploadArray
    })
    
}
