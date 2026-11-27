--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __re, __re_test = __JSR.__re, __JSR.__re_test
local ____exports = {}
window.DAROCA_DEV = false
if __re_test(
    __re("[?&]dev\\b", ""),
    window.location.search
) then
    window.DAROCA_DEV = true
end
return ____exports
