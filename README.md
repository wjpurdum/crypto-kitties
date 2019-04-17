## Calculating Emissions from CryptoKitty Transfers

### Developed using Truffle framework for initial set-up, compiling and migrating contract
### Project overview:
1. Constructor takes in account and digit-location of previous owner, account and digit location of new owner, and id of kitty in transit
2. Using the digit locations, the CO2 emission in metric tons is calculated using helper methods
3. An event is emitted on final calculation to confirm the following:
    (1) That the event has completed
    (2) The final emission count in metric tons
    (3) THe address of the old owner
    (4) The address of the new owner
    (5) The id of the kitty in transit
4. Error handling - the calculation will not be run if:
    a. The new owner and previous owner have the same address
    b. The previous owner did not not initiate the contract (msg.sender)

Given more time, I would implement the following:
1. Unit tests for helper functions
2. Figure out how to extract the last 9 digits from the address and store as a raw integer to perform the distance calculations in meters using addresses only




