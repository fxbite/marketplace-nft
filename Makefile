# This Makefile will interact the contract.

.PHONY: all

CMD_RUN = npx hardhat run 
CMD_TEST = npx hardhat test
SCRIPT_PATH_RUN = scripts/interaction
SCRIPT_PATH_TEST = test
NETWORK = --network sepolia

all: testToken

testToken:
	$(CMD_TEST) $(SCRIPT_PATH_TEST)/Token.ts $(NETWORK)


	

  