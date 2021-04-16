const expect          = require("chai").expect;
const origin_response = require("../src/origin_response.js");

fixture = {
  "Records": [
    {
      "cf": {
        "config": {
          "distributionId": "EXAMPLE"
        },
        "response": {
          "status": "200",
          "statusDescription": "OK",
          "headers": {
            "server": [
              {
                "key": "Server",
                "value": "S3"
              }
            ],
            "vary": [
              {
                "key": "Vary",
                "value": "*"
              }
            ],
            "last-modified": [
              {
                "key": "Last-Modified",
                "value": "2016-11-25"
              }
            ],
            "x-amz-meta-last-modified": [
              {
                "key": "X-Amz-Meta-Last-Modified",
                "value": "2016-01-01"
              }
            ]
          }
        }
      }
    }
  ]
}

describe("origin_response", function() {
  it('has headers', async () => {
    const result = await origin_response.handler(fixture);
    expect(result).to.have.any.keys('headers');
  })

  it('has expect-ct', async () => {
    const result = await origin_response.handler(fixture);
    expect(result["headers"]).to.have.any.keys('expect-ct');
  })

  it('does not have server', async () => {
    const result = await origin_response.handler(fixture);
    expect(result["headers"]).to.not.have.any.keys('server');
  })

  it('has headers that are in the CloudFront format', async () => {
    const result = await origin_response.handler(fixture);

    Object.keys(result["headers"]).forEach(function(e){
      expect(e).to.match(/^[a-z\-]+$/);

      const header = result["headers"][e][0];

      expect(header).to.have.property('key');
      expect(header.key).to.match(/^[a-zA-Z\-]+$/);

      expect(header.key.toLowerCase()).to.equal(e);

      expect(header).to.have.property('value');
    });
  })
});
