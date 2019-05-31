local bit32 = require 'bit32'
local I2C = require 'periphery'.I2C

local M = {
  BlinkRate = {
    [      'OFF'] = 0x00,
    ['DISPLAYON'] = 0x00,
    [  'HALF_HZ'] = 0x06,
    [     '1_HZ'] = 0x04,
    [     '2_HZ'] = 0x02
  },
  DEVICE = 0x70,
  Command = {
    SYSTEM_SETUP = 0x20,
    BLINK        = 0x80,
    BRIGHTNESS   = 0xe0,
    OSCILLATOR   = 0x01
  }
}

-- Turn off all LEDs, and set max brightness
function M.init(i2c)
  -- TODO turn off all LEDs
  M.setBrightness(i2c, device, 15)
end

function M.setBrightness(i2c, device, brightness)
  assert(brightness >= 0 and brightness <= 15)
  local msgs = {{bit32.band(M.Command.BRIGHTNESS, brightness)}}
  i2c:transfer(device or M.DEVICE, msgs)
end

return M
