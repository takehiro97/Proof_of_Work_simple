//hardhatの機能を使えるようにする命令
const hre = require("hardhat");

//SimpleBankのコントラクトをブロックチェーン上にデプロイする処理
async function main(){
    const Bank = await hre.ethers.getContractFactory("SimpleBank");
    const bank = await Bank.deploy();
    await bank.deployed();
    console.log("Deployed to:", bank.address);

    //mainを実行してエラーが出たら表示する

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});