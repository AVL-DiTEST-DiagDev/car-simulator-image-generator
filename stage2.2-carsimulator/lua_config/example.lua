-- place this file into /dist/Debug/GNU-Linux/lua_config/

-- for all lua functions check
-- README:md in the main folder
Main = {
   RequestId = 0x7E0,
   ResponseId = 0x7E8,
   RequestFunctionalId = 0x7DF,

   Raw = {
        -- this is a hard coded response that will answer with the ambient air temperature of 20°C
        -- OBD2 Standard PIDs
        
        ["01 46"] = "41 46 40",
        -- you can also send the answer via sendRaw
        ["01 0C"] = function(request)
            sendRaw("41 0C 01 FF")
            return 1
        end,
        --the following function is a wildcard
        -- if there is no exact match for the request (27 02...), it will jump into this function
        ["05 01 *"] = function(request)
            local answer = "45 01 00";
            return answer;
        end,
        
   }
}

