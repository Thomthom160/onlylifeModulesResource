---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 21/04/2019 21:20
---


---round
---@param num number
---@param numDecimalPlaces number
---@return number
---@public
function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

---starts
---@param String string
---@param Start number
---@return number
---@public
function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

---@type table
OnlylifeUI.Menus = setmetatable({}, OnlylifeUI.Menus)

---@type table
---@return boolean
OnlylifeUI.Menus.__call = function()
    return true
end

---@type table
OnlylifeUI.Menus.__index = OnlylifeUI.Menus

---@type table
OnlylifeUI.CurrentMenu = nil

---@type table
OnlylifeUI.NextMenu = nil

---@type number
OnlylifeUI.Options = 0

---@type number
OnlylifeUI.ItemOffset = 0

---@type number
OnlylifeUI.StatisticPanelCount = 0

---@type table
OnlylifeUI.UI = {
    Current = "OnlylifeUI",
    Style = {
        OnlylifeUI = {
            Width = 0
        },
        NativeUI = {
            Width = 0
        }
    }
}

---@type table
OnlylifeUI.Settings = {
    Debug = false,
    Controls = {
        Up = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 172 },
                { 1, 172 },
                { 2, 172 },
                { 0, 241 },
                { 1, 241 },
                { 2, 241 },
            },
        },
        Down = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 173 },
                { 1, 173 },
                { 2, 173 },
                { 0, 242 },
                { 1, 242 },
                { 2, 242 },
            },
        },
        Left = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        Right = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        SliderLeft = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        SliderRight = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        Select = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 201 },
                { 1, 201 },
                { 2, 201 },
            },
        },
        Back = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 177 },
                { 1, 177 },
                { 2, 177 },
                { 0, 199 },
                { 1, 199 },
                { 2, 199 },
            },
        },
        Click = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 24 },
            },
        },
        Enabled = {
            Controller = {
                { 0, 2 }, -- Look Up and Down
                { 0, 1 }, -- Look Left and Right
                { 0, 25 }, -- Aim
                { 0, 24 }, -- Attack
            },
            Keyboard = {
                { 0, 201 }, -- Select
                { 0, 195 }, -- X axis
                { 0, 196 }, -- Y axis
                { 0, 187 }, -- Down
                { 0, 188 }, -- Up
                { 0, 189 }, -- Left
                { 0, 190 }, -- Right
                { 0, 202 }, -- Back
                { 0, 217 }, -- Select
                { 0, 242 }, -- Scroll down
                { 0, 241 }, -- Scroll up
                { 0, 239 }, -- Cursor X
                { 0, 240 }, -- Cursor Y
                { 0, 31 }, -- Move Up and Down
                { 0, 30 }, -- Move Left and Right
                { 0, 21 }, -- Sprint
                { 0, 22 }, -- Jump
                { 0, 23 }, -- Enter
                { 0, 75 }, -- Exit Vehicle
                { 0, 71 }, -- Accelerate Vehicle
                { 0, 72 }, -- Vehicle Brake
                { 0, 59 }, -- Move Vehicle Left and Right
                { 0, 89 }, -- Fly Yaw Left
                { 0, 9 }, -- Fly Left and Right
                { 0, 8 }, -- Fly Up and Down
                { 0, 90 }, -- Fly Yaw Right
                { 0, 76 }, -- Vehicle Handbrake
            },
        },
    },
    Audio = {
        Id = nil,
        Use = "OnlylifeUI",
        OnlylifeUI = {
            UpDown = {
                audioName = "HUD_FREEMODE_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        },
        NativeUI = {
            UpDown = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        }
    },
    Items = {
        Title = {
            Background = { Width = 431, Height = 107 },
            Text = { X = 215, Y = 20, Scale = 1.15 },
        },
        Subtitle = {
            Background = { Width = 431, Height = 37 },
            Text = { X = 8, Y = 3, Scale = 0.35 },
            PreText = { X = 425, Y = 3, Scale = 0.35 },
        },
        Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 0, Width = 431 },
        Navigation = {
            Rectangle = { Width = 431, Height = 18 },
            Offset = 5,
            Arrows = { Dictionary = "commonmenu", Texture = "shop_arrows_upanddown", X = 190, Y = -6, Width = 50, Height = 50 },
        },
        Description = {
            Bar = { Y = 4, Width = 431, Height = 4 },
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 30 },
            Text = { X = 8, Y = 10, Scale = 0.35 },
        },
    },
    Panels = {
        Grid = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275 },
            Grid = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", X = 115.5, Y = 47.5, Width = 200, Height = 200 },
            Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
            Text = {
                Top = { X = 215.5, Y = 15, Scale = 0.35 },
                Bottom = { X = 215.5, Y = 250, Scale = 0.35 },
                Left = { X = 57.75, Y = 130, Scale = 0.35 },
                Right = { X = 373.25, Y = 130, Scale = 0.35 },
            },
        },
        Percentage = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 76 },
            Bar = { X = 9, Y = 50, Width = 413, Height = 10 },
            Text = {
                Left = { X = 25, Y = 15, Scale = 0.35 },
                Middle = { X = 215.5, Y = 15, Scale = 0.35 },
                Right = { X = 398, Y = 15, Scale = 0.35 },
            },
        },
    },
}

function OnlylifeUI.SetScaleformParams(scaleform, data)
    data = data or {}
    for k, v in pairs(data) do
        PushScaleformMovieFunction(scaleform, v.name)
        if v.param then
            for _, par in pairs(v.param) do
                if math.type(par) == "integer" then
                    PushScaleformMovieFunctionParameterInt(par)
                elseif type(par) == "boolean" then
                    PushScaleformMovieFunctionParameterBool(par)
                elseif math.type(par) == "float" then
                    PushScaleformMovieFunctionParameterFloat(par)
                elseif type(par) == "string" then
                    PushScaleformMovieFunctionParameterString(par)
                end
            end
        end
        if v.func then
            v.func()
        end
        PopScaleformMovieFunctionVoid()
    end
end

---Visible
---@param Menu function
---@param Value boolean
---@return table
---@public
function OnlylifeUI.Visible(Menu, Value)
    if Menu ~= nil then
        if Menu() then
            if type(Value) == "boolean" then
                if Value then
                    if OnlylifeUI.CurrentMenu ~= nil then
                        OnlylifeUI.CurrentMenu.Closed()
                        OnlylifeUI.CurrentMenu.Open = not Value
                    end
                    Menu:UpdateInstructionalButtons(Value);
                    Menu:UpdateCursorStyle();
                    OnlylifeUI.CurrentMenu = Menu
                    menuOpen = true
                else
                    menuOpen = false
                    OnlylifeUI.CurrentMenu = nil
                end
                Menu.Open = Value
                OnlylifeUI.Options = 0
                OnlylifeUI.ItemOffset = 0
                OnlylifeUI.LastControl = false
            else
                return Menu.Open
            end
        end
    end
end 

function OnlylifeUI.CloseAll()
    menuOpen = false

    if OnlylifeUI.CurrentMenu ~= nil then
        local parent = OnlylifeUI.CurrentMenu.Parent
        while parent ~= nil do
            parent.Index = 1
            parent.Pagination.Minimum = 1
            parent.Pagination.Maximum = 10
            parent = parent.Parent
        end
        OnlylifeUI.CurrentMenu.Index = 1
        OnlylifeUI.CurrentMenu.Pagination.Minimum = 1
        OnlylifeUI.CurrentMenu.Pagination.Maximum = 10
        OnlylifeUI.CurrentMenu.Open = false
        OnlylifeUI.CurrentMenu = nil
    end
    OnlylifeUI.Options = 0
    OnlylifeUI.ItemOffset = 0
    ResetScriptGfxAlign()
end

---Banner
---@return nil
---@public
---@param Enabled boolean
function OnlylifeUI.Banner(Enabled, Glare)
    if type(Enabled) == "boolean" then
        if Enabled == true then


            if OnlylifeUI.CurrentMenu ~= nil then
                if OnlylifeUI.CurrentMenu() then


                    OnlylifeUI.ItemsSafeZone(OnlylifeUI.CurrentMenu)

                    if OnlylifeUI.CurrentMenu.Sprite then
                        RenderSprite(OnlylifeUI.CurrentMenu.Sprite.Dictionary, OnlylifeUI.CurrentMenu.Sprite.Texture, OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y, OnlylifeUI.Settings.Items.Title.Background.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Title.Background.Height, nil)
                    else
                        RenderRectangle(OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y, OnlylifeUI.Settings.Items.Title.Background.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Title.Background.Height, OnlylifeUI.CurrentMenu.Rectangle.R, OnlylifeUI.CurrentMenu.Rectangle.G, OnlylifeUI.CurrentMenu.Rectangle.B, OnlylifeUI.CurrentMenu.Rectangle.A)
                    end

                    --if (OnlylifeUI.CurrentMenu.WidthOffset == 100) then
                        if Glare then

                            local ScaleformMovie = RequestScaleformMovie("MP_MENU_GLARE")
                            while not HasScaleformMovieLoaded(ScaleformMovie) do
                                Citizen.Wait(0)
                            end

							---@type number
							local Glarewidth = OnlylifeUI.Settings.Items.Title.Background.Width

							---@type number
							local Glareheight = OnlylifeUI.Settings.Items.Title.Background.Height
							---@type number
							local GlareX = OnlylifeUI.CurrentMenu.X / 1920 + (OnlylifeUI.CurrentMenu.SafeZoneSize.X / (64.399 - (OnlylifeUI.CurrentMenu.WidthOffset * 0.065731)))
                            ---@type number
                            local GlareY = OnlylifeUI.CurrentMenu.Y / 1080 + OnlylifeUI.CurrentMenu.SafeZoneSize.Y / 33.195020746888
                            OnlylifeUI.SetScaleformParams(ScaleformMovie, {
                                { name = "SET_DATA_SLOT", param = { GetGameplayCamRelativeHeading() } }
                            })

                            DrawScaleformMovie(ScaleformMovie, GlareX, GlareY, Glarewidth / 430, Glareheight / 100, 255, 255, 255, 255, 0)

                        end
                    --end

                    RenderText(OnlylifeUI.CurrentMenu.Title, OnlylifeUI.CurrentMenu.X + OnlylifeUI.Settings.Items.Title.Text.X + (OnlylifeUI.CurrentMenu.WidthOffset / 2), OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Title.Text.Y, 4, OnlylifeUI.Settings.Items.Title.Text.Scale, 255, 255, 255, 255, 1)
                    OnlylifeUI.ItemOffset = OnlylifeUI.ItemOffset + OnlylifeUI.Settings.Items.Title.Background.Height
                end
            end
        end
    else
        error("Enabled is not boolean")
    end
end

---CloseAll -- TODO 
---@return nil
---@public
-- function OnlylifeUI:CloseAll()
--     OnlylifeUI.PlaySound(OnlylifeUI.Settings.Audio.Library, OnlylifeUI.Settings.Audio.Back)
--     OnlylifeUI.NextMenu = nil
--     OnlylifeUI.Visible(OnlylifeUI.CurrentMenu, false)
-- end

---Subtitle
---@return nil
---@public
function OnlylifeUI.Subtitle()
    if OnlylifeUI.CurrentMenu ~= nil then
        if OnlylifeUI.CurrentMenu() then
            OnlylifeUI.ItemsSafeZone(OnlylifeUI.CurrentMenu)
            if OnlylifeUI.CurrentMenu.Subtitle ~= "" then
                RenderRectangle(OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Subtitle.Background.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Subtitle.Background.Height + OnlylifeUI.CurrentMenu.SubtitleHeight, 0, 0, 0, 255)
                RenderText(OnlylifeUI.CurrentMenu.Subtitle, OnlylifeUI.CurrentMenu.X + OnlylifeUI.Settings.Items.Subtitle.Text.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Subtitle.Text.Y + OnlylifeUI.ItemOffset, 0, OnlylifeUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, OnlylifeUI.Settings.Items.Subtitle.Background.Width + OnlylifeUI.CurrentMenu.WidthOffset)
                if OnlylifeUI.CurrentMenu.Index > OnlylifeUI.CurrentMenu.Options or OnlylifeUI.CurrentMenu.Index < 0 then
                    OnlylifeUI.CurrentMenu.Index = 1
                end
                OnlylifeUI.RefreshPagination()
                if OnlylifeUI.CurrentMenu.PageCounter == nil then
                    RenderText(OnlylifeUI.CurrentMenu.PageCounterColour .. OnlylifeUI.CurrentMenu.Index .. " / " .. OnlylifeUI.CurrentMenu.Options, OnlylifeUI.CurrentMenu.X + OnlylifeUI.Settings.Items.Subtitle.PreText.X + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Subtitle.PreText.Y + OnlylifeUI.ItemOffset, 0, OnlylifeUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                else
                    RenderText(OnlylifeUI.CurrentMenu.PageCounter, OnlylifeUI.CurrentMenu.X + OnlylifeUI.Settings.Items.Subtitle.PreText.X + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Subtitle.PreText.Y + OnlylifeUI.ItemOffset, 0, OnlylifeUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                end
                OnlylifeUI.ItemOffset = OnlylifeUI.ItemOffset + OnlylifeUI.Settings.Items.Subtitle.Background.Height
            end
        end
    end
end

---Background
---@return nil
---@public
function OnlylifeUI.Background()
    if OnlylifeUI.CurrentMenu ~= nil then
        if OnlylifeUI.CurrentMenu() then
            OnlylifeUI.ItemsSafeZone(OnlylifeUI.CurrentMenu)
            SetScriptGfxDrawOrder(0)
            RenderSprite(OnlylifeUI.Settings.Items.Background.Dictionary, OnlylifeUI.Settings.Items.Background.Texture, OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Background.Y + OnlylifeUI.CurrentMenu.SubtitleHeight, OnlylifeUI.Settings.Items.Background.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.ItemOffset, 255, 255, 255)
            SetScriptGfxDrawOrder(1)
        end
    end
end

---Description
---@return nil
---@public
function OnlylifeUI.Description()
    if OnlylifeUI.CurrentMenu ~= nil and OnlylifeUI.CurrentMenu.Description ~= nil then
        if OnlylifeUI.CurrentMenu() then
            OnlylifeUI.ItemsSafeZone(OnlylifeUI.CurrentMenu)
            RenderRectangle(OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Description.Bar.Y + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Description.Bar.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Description.Bar.Height, 255, 255, 255)
            RenderSprite(OnlylifeUI.Settings.Items.Description.Background.Dictionary, OnlylifeUI.Settings.Items.Description.Background.Texture, OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Description.Background.Y + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Description.Background.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.CurrentMenu.DescriptionHeight, 255, 255, 255)
            RenderText(OnlylifeUI.CurrentMenu.Description, OnlylifeUI.CurrentMenu.X + OnlylifeUI.Settings.Items.Description.Text.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Description.Text.Y + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, 0, OnlylifeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, OnlylifeUI.Settings.Items.Description.Background.Width + OnlylifeUI.CurrentMenu.WidthOffset - 8.0)
            OnlylifeUI.ItemOffset = OnlylifeUI.ItemOffset + OnlylifeUI.CurrentMenu.DescriptionHeight + OnlylifeUI.Settings.Items.Description.Bar.Y
        end
    end
end

---Render
---@param instructionalButton boolean
---@return nil
---@public
function OnlylifeUI.Render(instructionalButton)
    if OnlylifeUI.CurrentMenu ~= nil then
        if OnlylifeUI.CurrentMenu() then
            if OnlylifeUI.CurrentMenu.Safezone then
                ResetScriptGfxAlign()
            end
            if (instructionalButton) then
                DrawScaleformMovieFullscreen(OnlylifeUI.CurrentMenu.InstructionalScaleform, 255, 255, 255, 255, 0)
            end
            OnlylifeUI.CurrentMenu.Options = OnlylifeUI.Options
            OnlylifeUI.CurrentMenu.SafeZoneSize = nil
            OnlylifeUI.Controls()
            OnlylifeUI.Options = 0
            OnlylifeUI.StatisticPanelCount = 0
            OnlylifeUI.ItemOffset = 0
            if OnlylifeUI.CurrentMenu.Controls.Back.Enabled and OnlylifeUI.CurrentMenu.Closable then
                if OnlylifeUI.CurrentMenu.Controls.Back.Pressed then
                    OnlylifeUI.CurrentMenu.Controls.Back.Pressed = false
                    local Audio = OnlylifeUI.Settings.Audio
                    OnlylifeUI.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
                    if OnlylifeUI.CurrentMenu.Closed ~= nil then
                        collectgarbage()
                        OnlylifeUI.CurrentMenu.Closed()
                    end
                    if OnlylifeUI.CurrentMenu.Parent ~= nil then
                        if OnlylifeUI.CurrentMenu.Parent() then
                            OnlylifeUI.NextMenu = OnlylifeUI.CurrentMenu.Parent
                            OnlylifeUI.CurrentMenu:UpdateCursorStyle()
                        else
                            --print('xxx') Debug print
                            OnlylifeUI.NextMenu = nil
                            OnlylifeUI.Visible(OnlylifeUI.CurrentMenu, false)
                        end
                    else
                        --print('zz') Debug print
                        OnlylifeUI.NextMenu = nil
                        OnlylifeUI.Visible(OnlylifeUI.CurrentMenu, false)
                    end
                end
            end
            if OnlylifeUI.NextMenu ~= nil then
                if OnlylifeUI.NextMenu() then
                    OnlylifeUI.Visible(OnlylifeUI.CurrentMenu, false)
                    OnlylifeUI.Visible(OnlylifeUI.NextMenu, true)
                    OnlylifeUI.CurrentMenu.Controls.Select.Active = false
                    OnlylifeUI.NextMenu = nil
                    OnlylifeUI.LastControl = false
                end
            end
        end
    end
end

---ItemsDescription
---@param CurrentMenu table
---@param Description string
---@param Selected boolean
---@return nil
---@public
function OnlylifeUI.ItemsDescription(CurrentMenu, Description, Selected)
    ---@type table
    if Description ~= "" or Description ~= nil then
        local SettingsDescription = OnlylifeUI.Settings.Items.Description;
        if Selected and CurrentMenu.Description ~= Description then
            CurrentMenu.Description = Description or nil
            ---@type number
            local DescriptionLineCount = GetLineCount(CurrentMenu.Description, CurrentMenu.X + SettingsDescription.Text.X, CurrentMenu.Y + SettingsDescription.Text.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, 0, SettingsDescription.Text.Scale, 255, 255, 255, 255, nil, false, false, SettingsDescription.Background.Width + (CurrentMenu.WidthOffset - 5.0))
            if DescriptionLineCount > 1 then
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height * DescriptionLineCount
            else
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height + 7
            end
        end
    end
end

---MouseBounds
---@param CurrentMenu table
---@param Selected boolean
---@param Option number
---@param SettingsButton table
---@return boolean
---@public
function OnlylifeUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)
    ---@type boolean
    local Hovered = false
    Hovered = OnlylifeUI.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height)
    if Hovered and not Selected then
        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height, 255, 255, 255, 20)
        if CurrentMenu.Controls.Click.Active then
            CurrentMenu.Index = Option
            local Audio = OnlylifeUI.Settings.Audio
            OnlylifeUI.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
        end
    end
    return Hovered;
end

---ItemsSafeZone
---@param CurrentMenu table
---@return nil
---@public
function OnlylifeUI.ItemsSafeZone(CurrentMenu)
    if not CurrentMenu.SafeZoneSize then
        CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }
        if CurrentMenu.Safezone then
            CurrentMenu.SafeZoneSize = OnlylifeUI.GetSafeZoneBounds()
            SetScriptGfxAlign(76, 84)
            SetScriptGfxAlignParams(0, 0, 0, 0)
        end
    end
end

function OnlylifeUI.CurrentIsEqualTo(Current, To, Style, DefaultStyle)
    if (Current == To) then
        return Style;
    else
        return DefaultStyle or {};
    end
end

function OnlylifeUI.RefreshPagination()
    if (OnlylifeUI.CurrentMenu ~= nil) then
        if (OnlylifeUI.CurrentMenu.Index > 10) then
            local offset = OnlylifeUI.CurrentMenu.Index - 10
            OnlylifeUI.CurrentMenu.Pagination.Minimum = 1 + offset
            OnlylifeUI.CurrentMenu.Pagination.Maximum = 10 + offset
        else
            OnlylifeUI.CurrentMenu.Pagination.Minimum = 1
            OnlylifeUI.CurrentMenu.Pagination.Maximum = 10
        end
    end
end

function OnlylifeUI.IsVisible(menu, header, glare, instructional, items, panels)
    if (OnlylifeUI.Visible(menu)) then
        if (header == true) then
            OnlylifeUI.Banner(true, glare or false)
        end
        OnlylifeUI.Subtitle()
        if (items ~= nil) then
            items()
        end
        OnlylifeUI.Background();
        OnlylifeUI.Navigation();
        OnlylifeUI.Description();
        if (panels ~= nil) then
            panels()
        end
        OnlylifeUI.Render(instructional or false)
    end
end


---CreateWhile
---@param wait number
---@param menu table
---@param key number
---@param closure function
---@return void
---@public
function OnlylifeUI.CreateWhile(wait, menu, key, closure)
    Citizen.CreateThread(function()
        while (true) do
            Citizen.Wait(wait or 0.1)

            if (key ~= nil) then
                if IsControlJustPressed(1, key) then
                    OnlylifeUI.Visible(menu, not OnlylifeUI.Visible(menu))
                end
            end

            closure()
        end
    end)
end

---SetStyleAudio
---@param StyleAudio string
---@return void
---@public
function OnlylifeUI.SetStyleAudio(StyleAudio)
    OnlylifeUI.Settings.Audio.Use = StyleAudio or "OnlylifeUI"
end

function OnlylifeUI.GetStyleAudio()
    return OnlylifeUI.Settings.Audio.Use or "OnlylifeUI"
end

