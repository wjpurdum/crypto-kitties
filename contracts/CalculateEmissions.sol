pragma solidity >= 0.4 .22 < 0.6 .0;

contract CalculateKittyTransferEmissions {
  address public prevOwner;
  address public newOwner;
  uint public totalEmissionsinMetricTons;
  uint public newOwnerDistance;
  uint public prevOwnerDistance;
  bool public emissionsCalculationComplete;
  uint public kittyInTransit;
  
  event TotalTransferEmissionsCalculated(bool emissionsCalculationComplete, uint totalEmissionsinMetricTons, address prevOwner, address receiver, uint kittyInTransit);
  
  constructor(address _prevOwner, uint prevOwner_digits, address _newOwner, uint newOwner_digits, uint256 _kittyId) public {
    prevOwner = _prevOwner;
    newOwner = _newOwner;
    newOwnerDistance = newOwner_digits;
    prevOwnerDistance = prevOwner_digits;
    kittyInTransit = _kittyId;
  }

  /* Method to convert distance from meters to kilometers: */
  function convertMetersToKilometers (uint distanceInMeters) internal pure returns(uint) {
    return distanceInMeters / 1000;
  }

  /* Method to convert grams to metric tons:*/
  function convertGramsToMetricTons (uint emissionInGrams) internal pure returns(uint) {
    return emissionInGrams / 1000000;
  }

  /* Method to calculate emissions in grams based on distance traveled in kilometers */
  function getEmissionsInGrams (uint distanceInKlmts) internal pure returns(uint) {
    return distanceInKlmts * 100;
  }

  /* Method to calculate grams emitted based on kilometers traveled: */
  function calculateEmissions (uint newOwnerDistance, uint prevOwnerDistance) internal {
    /* Check that only the sender can initiate this call */
    require (msg.sender == prevOwner, "Only the previous owner can initiate a transfer calculation");
    
    /* Check that the new owner is different than the previus owner */
    require (prevOwner != newOwner, "Error - transfer cannot occur between the same addresses");
   
    //Get distance in meters based on address of new and previous owner
    uint distanceInMeters = newOwnerDistance - prevOwnerDistance;

    //Convert distance in meters to distance in kilometers
    uint distanceInKilometers = convertMetersToKilometers(distanceInMeters);

    //Get Co2 emission in grams based on distance traveled in kilometers
    uint emissionsInGrams = getEmissionsInGrams(distanceInKilometers);

    //Convert emission in grams to emisions in metric tons
    totalEmissionsinMetricTons = convertGramsToMetricTons(emissionsInGrams);

    //Complete the emissions calculation and emit event 
    emissionsCalculationComplete = true;
    emit TotalTransferEmissionsCalculated(emissionsCalculationComplete, totalEmissionsinMetricTons, prevOwner, newOwner, kittyInTransit);
  }

  function getTotalEmissions () public view returns(uint) {
    return totalEmissionsinMetricTons;
  }
}

