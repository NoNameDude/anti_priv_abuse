local colorize = minetest.colorize
local storage = minetest.get_mod_storage()

function load_general_priv_check()
    local data = storage:get_string("Checked")
    if data then
        data = minetest.deseralize(data)
        --created a table if none exists
        if type(data) ~= "table" then
            data = {}
        end
    end 
    return data
end

function save_general_priv_check(data)
    if type(data) == "table" then
        storage:set_string("Checked", minetest.serialize(data))
    end
    --Epmty the table might not be needed
    data = {}
end

function check_if_checked(name)
    local check = false
    data = load_general_priv_check()
    if data[name] ~= nil then
        check = true
    end
    return check      
end

--Put staff members in here
local staffs = {
    --"Example xXNicoXx",
    --"Example Lux"
}



minetest.register_on_joinplayer(function(player)
    local name = player and player:get_player_name()
    local lever = true
    local privs = minetest.get_player_privs(name)
    local data = load_general_priv_check(name)

    for _, staff in pairs(staffs) do
        if name == staff then
            minetest.chat_send_player(name, colorize("#008800", "[Server] Welcome back staff member"))
            lever = false
            break
        end  
    end
    if lever == true then
        if data ~= true then
            --Privs can be changed ofc
            minetest.set_player_privs(name, {interact = true, shout = true, home = true})
        end
    end
    save_general_priv_check(data)
end)
