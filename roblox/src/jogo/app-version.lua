--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord = __JSR.__ord
local ____exports = {}
window.DAROCA_APP_VERSION = __ord({versionCode = 101, versionName = "3.13.1", configRevision = 21, updateUrl = "/api/updates"}, "versionCode,versionName,configRevision,updateUrl")
return ____exports
