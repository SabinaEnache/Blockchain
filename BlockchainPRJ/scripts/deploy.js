const hre = require("hardhat");

async function main() {
    console.log("Starting deployment...");

    const TokenBanit = await hre.ethers.getContractFactory("TokenBanit");
    console.log("Contract Factory for TokenBanit loaded.");

    const tokenBanit = await TokenBanit.deploy();
    console.log("Deploy transaction sent. Waiting for confirmation...");
    await tokenBanit.waitForDeployment(); // Înlocuiește deployTransaction.wait()
    console.log("TokenBanit deployed to:", await tokenBanit.getAddress()); // Folosește getAddress()

    console.log("Deploying PuncteFidelitate...");
    const PuncteFidelitate = await hre.ethers.getContractFactory("PuncteFidelitate");
    const puncteFidelitate = await PuncteFidelitate.deploy(await tokenBanit.getAddress());
    await puncteFidelitate.waitForDeployment(); // Înlocuiește deployTransaction.wait()
    console.log("PuncteFidelitate deployed to:", await puncteFidelitate.getAddress());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error("Error during deployment:", error);
        process.exit(1);
    });
