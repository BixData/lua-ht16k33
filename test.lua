print('Begin test')

local ht16k33 = require 'ht16k33'
local periphery = require 'periphery'

-- ============================================================================
-- Mini test framework
-- ============================================================================

local failures = 0

local function assertEquals(expected,actual,message)
  message = message or string.format('Expected %s but got %s', tostring(expected), tostring(actual))
  assert(actual==expected, message)
end

local function it(message, testFn)
  local status, err =  pcall(testFn)
  if status then
    print(string.format('✓ %s', message))
  else
    print(string.format('✖ %s', message))
    print(string.format('  FAILED: %s', err))
    failures = failures + 1
  end
end


-- ============================================================================
-- ht16k33 module
-- ============================================================================

it('construct 8x8 matrix facade', function()
  local i2c = {transfer=function()end} --local i2c = periphery.I2C('/dev/i2c-1')
  local matrix = ht16k33.newMatrix8x8(i2c, nil)
end)

it('setBrightness', function()
  local i2c = periphery.I2C('/dev/i2c-1')
  ht16k33.init(i2c, nil)
  ht16k33.setBrightness(i2c, nil, 0)
end)

it('setAllOn', function()
  local i2c = periphery.I2C('/dev/i2c-1')
  local matrix = ht16k33.newMatrix8x8(i2c, nil)
  for j = 0,7 do
    for i = 0,7 do
      matrix:setPixel(i,j,true)
    end
  end
  matrix:write()
end)
