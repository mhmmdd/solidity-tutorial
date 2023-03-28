import {expect} from "chai";
import {ethers} from "hardhat";
import {BEEToken, LockERC20} from "../../typechain-types";
import {BigNumber} from "ethers";

function ethToNum(eth: BigNumber): number {
    return Number.parseFloat(ethers.utils.formatEther(eth));
}

describe("LockERC20 Contract", function () {
    let owner: any, user1: any, user2: any;
    let Token, token: BEEToken;
    let Lock, lock: LockERC20

    let balances: number[];

    // We define a fixture to reuse the same setup in every test.
    before(async function () {
        [owner, user1, user2] = await ethers.getSigners();

        Token = await ethers.getContractFactory("BEEToken");
        token = await Token.deploy();
        await token.deployed();

        Lock = await ethers.getContractFactory("LockERC20");
        lock = await Lock.connect(owner).deploy(token.address);
        await lock.deployed();

        // Transfer tokens to the users.
        await token.connect(owner).transfer(user1.address, ethers.utils.parseUnits("100", 18));
        await token.connect(owner).transfer(user2.address, ethers.utils.parseEther("50"));

        // Approve the lock contract to spend the tokens
        await token.connect(user1).approve(lock.address, ethers.utils.parseUnits("100", 18));
        await token.connect(user2).approve(lock.address, ethers.utils.parseEther("50"));
    });

    // Deploys the contracts
    it("Deploys the contracts", async function () {
        expect(token.address).to.properAddress;
        expect(lock.address).to.properAddress;
    });

    it("Send tokens to the lock contract", async function () {
        expect(await token.balanceOf(owner.address)).to.greaterThan(0);
        expect(await token.balanceOf(user1.address)).to.equal(ethers.utils.parseUnits("100", 18));
        expect(await token.balanceOf(user2.address)).to.equal(ethers.utils.parseEther("50"));

        // Before sending tokens to the lock contract, the lock contract should have 0 tokens.
        expect(await token.balanceOf(lock.address)).to.equal(0);
    });

    it("Allowance should be set correctly", async function () {
        expect(await token.allowance(user1.address, lock.address)).to.equal(ethers.utils.parseUnits("100", 18));
        expect(await token.allowance(user2.address, lock.address)).to.equal(ethers.utils.parseEther("50"));
    });

    it("Reverts exceeding transfer", async function () {
        // user1 has 100 tokens, but tries to send 101 tokens to the user2.
        await expect(token.connect(user1).transfer(user2.address, ethers.utils.parseEther("101")))
            .to.be.revertedWith("ERC20: transfer amount exceeds balance");
    });

    describe("Contract functions", function () {

        let lockerCount: number = 0;
        let totalLockedAmount: number = 0;
        let userLocks: number[] = [0, 0];

        it("user1 locks 10 tokens", async function () {
            totalLockedAmount += 10;
            userLocks[0] += 10
            lockerCount++;

            // user1 locks 10 tokens.
            await lock.connect(user1).lock(ethers.utils.parseEther("10"));

            // Check the locker count and locked amount.
            expect(ethToNum(await lock.lockers(user1.address))).to.equal(userLocks[0]);
            expect(await token.balanceOf(lock.address)).to.equal(ethers.utils.parseEther(totalLockedAmount.toString()));
        })

        it("Locker count and locked amount increase", async function () {
            // Check the locker count and locked amount.
            expect(await lock.lockerCount()).to.equal(lockerCount);
            expect(ethToNum(await lock.totalLocked())).to.equal(totalLockedAmount);
        });

        it("user2 cannot withdraw", async function () {
            // user2 cannot withdraw tokens.
            await expect(lock.connect(user2).withdraw())
                .to.be.revertedWith("Nothing to withdraw");
        });

        it("user1 withdraws tokens", async function () {
            totalLockedAmount -= 10;
            userLocks[0] -= 10
            lockerCount--;

            // user1 withdraws tokens.
            await lock.connect(user1).withdraw();

            // Check the locker count and locked amount.
            expect(ethToNum(await lock.lockers(user1.address))).to.equal(userLocks[0]);
            expect(await token.balanceOf(lock.address)).to.equal(ethers.utils.parseEther(totalLockedAmount.toString()));
        });

        it("Locker count and locked amount decrease", async function () {
            // Check the locker count and locked amount.
            expect(await lock.lockerCount()).to.equal(lockerCount);
            expect(ethToNum(await lock.totalLocked())).to.equal(totalLockedAmount);
        });

        it("user1 position deleted", async function () {
            // user1 position is deleted.
            expect(ethToNum(await lock.lockers(user1.address))).to.equal(0);
        });

        it("user1 cannot withdraw again", async function () {
            // user1 cannot withdraw tokens.
            await expect(lock.connect(user1).withdraw())
                .to.be.revertedWith("Nothing to withdraw");
        });

    });

    it("Prints timestamps", async function () {
        let provider = ethers.provider;
        console.log("Current block number: ", await provider.getBlockNumber());
        console.log("Current block timestamp: ", (await provider.getBlock("latest")).timestamp);
    });
});

