---@type table
OnlylifeUI.LastControl = false

---IsMouseInBounds
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@return number
---@public
function OnlylifeUI.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = math.round(GetControlNormal(0, 239) * 1920) / 1920, math.round(GetControlNormal(0, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

---GetSafeZoneBounds
---@return table
---@public
function OnlylifeUI.GetSafeZoneBounds()
    local SafeSize = GetSafeZoneSize()
    SafeSize = math.round(SafeSize, 2)
    SafeSize = (SafeSize * 100) - 90
    SafeSize = 10 - SafeSize

    local W, H = 1920, 1080

    return { X = math.round(SafeSize * ((W / H) * 5.4)), Y = math.round(SafeSize * 5.4) }
end
---GoUp
---@param Options number
---@return nil
---@public
function OnlylifeUI.GoUp(Options)
    if OnlylifeUI.CurrentMenu ~= nil then
        Options = OnlylifeUI.CurrentMenu.Options
        if OnlylifeUI.CurrentMenu() then
            if (Options ~= 0) then
                if Options > OnlylifeUI.CurrentMenu.Pagination.Total then
                    if OnlylifeUI.CurrentMenu.Index <= OnlylifeUI.CurrentMenu.Pagination.Minimum then
                        if OnlylifeUI.CurrentMenu.Index == 1 then
                            OnlylifeUI.CurrentMenu.Pagination.Minimum = Options - (OnlylifeUI.CurrentMenu.Pagination.Total - 1)
                            OnlylifeUI.CurrentMenu.Pagination.Maximum = Options
                            OnlylifeUI.CurrentMenu.Index = Options
                        else
                            OnlylifeUI.CurrentMenu.Pagination.Minimum = (OnlylifeUI.CurrentMenu.Pagination.Minimum - 1)
                            OnlylifeUI.CurrentMenu.Pagination.Maximum = (OnlylifeUI.CurrentMenu.Pagination.Maximum - 1)
                            OnlylifeUI.CurrentMenu.Index = OnlylifeUI.CurrentMenu.Index - 1
                        end
                    else
                        OnlylifeUI.CurrentMenu.Index = OnlylifeUI.CurrentMenu.Index - 1
                    end
                else
                    if OnlylifeUI.CurrentMenu.Index == 1 then
                        OnlylifeUI.CurrentMenu.Pagination.Minimum = Options - (OnlylifeUI.CurrentMenu.Pagination.Total - 1)
                        OnlylifeUI.CurrentMenu.Pagination.Maximum = Options
                        OnlylifeUI.CurrentMenu.Index = Options
                    else
                        OnlylifeUI.CurrentMenu.Index = OnlylifeUI.CurrentMenu.Index - 1
                    end
                end

                local Audio = OnlylifeUI.Settings.Audio
                OnlylifeUI.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                OnlylifeUI.LastControl = true
            else
                local Audio = OnlylifeUI.Settings.Audio
                OnlylifeUI.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

---GoDown
---@param Options number
---@return nil
---@public
function OnlylifeUI.GoDown(Options)
    if OnlylifeUI.CurrentMenu ~= nil then
        Options = OnlylifeUI.CurrentMenu.Options
        if OnlylifeUI.CurrentMenu() then
            if (Options ~= 0) then
                if Options > OnlylifeUI.CurrentMenu.Pagination.Total then
                    if OnlylifeUI.CurrentMenu.Index >= OnlylifeUI.CurrentMenu.Pagination.Maximum then
                        if OnlylifeUI.CurrentMenu.Index == Options then
                            OnlylifeUI.CurrentMenu.Pagination.Minimum = 1
                            OnlylifeUI.CurrentMenu.Pagination.Maximum = OnlylifeUI.CurrentMenu.Pagination.Total
                            OnlylifeUI.CurrentMenu.Index = 1
                        else
                            OnlylifeUI.CurrentMenu.Pagination.Maximum = (OnlylifeUI.CurrentMenu.Pagination.Maximum + 1)
                            OnlylifeUI.CurrentMenu.Pagination.Minimum = OnlylifeUI.CurrentMenu.Pagination.Maximum - (OnlylifeUI.CurrentMenu.Pagination.Total - 1)
                            OnlylifeUI.CurrentMenu.Index = OnlylifeUI.CurrentMenu.Index + 1
                        end
                    else
                        OnlylifeUI.CurrentMenu.Index = OnlylifeUI.CurrentMenu.Index + 1
                    end
                else
                    if OnlylifeUI.CurrentMenu.Index == Options then
                        OnlylifeUI.CurrentMenu.Pagination.Minimum = 1
                        OnlylifeUI.CurrentMenu.Pagination.Maximum = OnlylifeUI.CurrentMenu.Pagination.Total
                        OnlylifeUI.CurrentMenu.Index = 1
                    else
                        OnlylifeUI.CurrentMenu.Index = OnlylifeUI.CurrentMenu.Index + 1
                    end
                end
                local Audio = OnlylifeUI.Settings.Audio
                OnlylifeUI.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                OnlylifeUI.LastControl = false
            else
                local Audio = OnlylifeUI.Settings.Audio
                OnlylifeUI.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

function OnlylifeUI.GoLeft(Controls)
    if Controls.Left.Enabled then
        for Index = 1, #Controls.Left.Keys do
            if not Controls.Left.Pressed then
                if IsDisabledControlJustPressed(Controls.Left.Keys[Index][1], Controls.Left.Keys[Index][2]) then
                    Controls.Left.Pressed = true

                    Citizen.CreateThread(function()
                        Controls.Left.Active = true

                        Citizen.Wait(0.01)

                        Controls.Left.Active = false

                        Citizen.Wait(174.99)

                        while Controls.Left.Enabled and IsDisabledControlPressed(Controls.Left.Keys[Index][1], Controls.Left.Keys[Index][2]) do
                            Controls.Left.Active = true

                            Citizen.Wait(0.01)

                            Controls.Left.Active = false

                            Citizen.Wait(124.99)
                        end

                        Controls.Left.Pressed = false
                        Wait(10)
                    end)

                    break
                end
            end
        end
    end
end

function OnlylifeUI.GoRight(Controls)
    if Controls.Right.Enabled then
        for Index = 1, #Controls.Right.Keys do
            if not Controls.Right.Pressed then
                if IsDisabledControlJustPressed(Controls.Right.Keys[Index][1], Controls.Right.Keys[Index][2]) then
                    Controls.Right.Pressed = true

                    Citizen.CreateThread(function()
                        Controls.Right.Active = true

                        Citizen.Wait(0.01)

                        Controls.Right.Active = false

                        Citizen.Wait(174.99)

                        while Controls.Right.Enabled and IsDisabledControlPressed(Controls.Right.Keys[Index][1], Controls.Right.Keys[Index][2]) do
                            Controls.Right.Active = true

                            Citizen.Wait(1)

                            Controls.Right.Active = false

                            Citizen.Wait(124.99)
                        end

                        Controls.Right.Pressed = false
                        Wait(10)
                    end)

                    break
                end
            end
        end
    end
end

function OnlylifeUI.GoSliderLeft(Controls)
    if Controls.SliderLeft.Enabled then
        for Index = 1, #Controls.SliderLeft.Keys do
            if not Controls.SliderLeft.Pressed then
                if IsDisabledControlJustPressed(Controls.SliderLeft.Keys[Index][1], Controls.SliderLeft.Keys[Index][2]) then
                    Controls.SliderLeft.Pressed = true
                    Citizen.CreateThread(function()
                        Controls.SliderLeft.Active = true
                        Citizen.Wait(1)
                        Controls.SliderLeft.Active = false
                        while Controls.SliderLeft.Enabled and IsDisabledControlPressed(Controls.SliderLeft.Keys[Index][1], Controls.SliderLeft.Keys[Index][2]) do
                            Controls.SliderLeft.Active = true
                            Citizen.Wait(1)
                            Controls.SliderLeft.Active = false
                        end
                        Controls.SliderLeft.Pressed = false
                    end)
                    break
                end
            end
        end
    end
end

function OnlylifeUI.GoSliderRight(Controls)
    if Controls.SliderRight.Enabled then
        for Index = 1, #Controls.SliderRight.Keys do
            if not Controls.SliderRight.Pressed then
                if IsDisabledControlJustPressed(Controls.SliderRight.Keys[Index][1], Controls.SliderRight.Keys[Index][2]) then
                    Controls.SliderRight.Pressed = true
                    Citizen.CreateThread(function()
                        Controls.SliderRight.Active = true
                        Citizen.Wait(1)
                        Controls.SliderRight.Active = false
                        while Controls.SliderRight.Enabled and IsDisabledControlPressed(Controls.SliderRight.Keys[Index][1], Controls.SliderRight.Keys[Index][2]) do
                            Controls.SliderRight.Active = true
                            Citizen.Wait(1)
                            Controls.SliderRight.Active = false
                        end
                        Controls.SliderRight.Pressed = false
                    end)
                    break
                end
            end
        end
    end
end

---Controls
---@return nil
---@public
function OnlylifeUI.Controls()
    if OnlylifeUI.CurrentMenu ~= nil then
        if OnlylifeUI.CurrentMenu() then
            if OnlylifeUI.CurrentMenu.Open then

                local Controls = OnlylifeUI.CurrentMenu.Controls;
                ---@type number
                local Options = OnlylifeUI.CurrentMenu.Options
                OnlylifeUI.Options = OnlylifeUI.CurrentMenu.Options
                if OnlylifeUI.CurrentMenu.EnableMouse then
                    DisableAllControlActions(2)
                end

                if not IsInputDisabled(2) then
                    for Index = 1, #Controls.Enabled.Controller do
                        EnableControlAction(Controls.Enabled.Controller[Index][1], Controls.Enabled.Controller[Index][2], true)
                    end
                else
                    for Index = 1, #Controls.Enabled.Keyboard do
                        EnableControlAction(Controls.Enabled.Keyboard[Index][1], Controls.Enabled.Keyboard[Index][2], true)
                    end
                end

                if Controls.Up.Enabled then
                    for Index = 1, #Controls.Up.Keys do
                        if not Controls.Up.Pressed then
                            if IsDisabledControlJustPressed(Controls.Up.Keys[Index][1], Controls.Up.Keys[Index][2]) then
                                Controls.Up.Pressed = true

                                Citizen.CreateThread(function()
                                    OnlylifeUI.GoUp(Options)

                                    Citizen.Wait(175)

                                    while Controls.Up.Enabled and IsDisabledControlPressed(Controls.Up.Keys[Index][1], Controls.Up.Keys[Index][2]) do
                                        OnlylifeUI.GoUp(Options)

                                        Citizen.Wait(50)
                                    end

                                    Controls.Up.Pressed = false
                                end)

                                break
                            end
                        end
                    end
                end

                if Controls.Down.Enabled then
                    for Index = 1, #Controls.Down.Keys do
                        if not Controls.Down.Pressed then
                            if IsDisabledControlJustPressed(Controls.Down.Keys[Index][1], Controls.Down.Keys[Index][2]) then
                                Controls.Down.Pressed = true

                                Citizen.CreateThread(function()
                                    OnlylifeUI.GoDown(Options)

                                    Citizen.Wait(175)

                                    while Controls.Down.Enabled and IsDisabledControlPressed(Controls.Down.Keys[Index][1], Controls.Down.Keys[Index][2]) do
                                        OnlylifeUI.GoDown(Options)

                                        Citizen.Wait(50)
                                    end

                                    Controls.Down.Pressed = false
                                end)

                                break
                            end
                        end
                    end
                end

                OnlylifeUI.GoLeft(Controls)
                --- Default Left navigation
                OnlylifeUI.GoRight(Controls) --- Default Right navigation

                OnlylifeUI.GoSliderLeft(Controls)
                OnlylifeUI.GoSliderRight(Controls)

                if Controls.Select.Enabled then
                    for Index = 1, #Controls.Select.Keys do
                        if not Controls.Select.Pressed then
                            if IsDisabledControlJustPressed(Controls.Select.Keys[Index][1], Controls.Select.Keys[Index][2]) then
                                Controls.Select.Pressed = true

                                Citizen.CreateThread(function()
                                    Controls.Select.Active = true

                                    Citizen.Wait(0.01)

                                    Controls.Select.Active = false

                                    Citizen.Wait(174.99)

                                    while Controls.Select.Enabled and IsDisabledControlPressed(Controls.Select.Keys[Index][1], Controls.Select.Keys[Index][2]) do
                                        Controls.Select.Active = true

                                        Citizen.Wait(0.01)

                                        Controls.Select.Active = false

                                        Citizen.Wait(124.99)
                                    end

                                    Controls.Select.Pressed = false

                                end)

                                break
                            end
                        end
                    end
                end

                if Controls.Click.Enabled then
                    for Index = 1, #Controls.Click.Keys do
                        if not Controls.Click.Pressed then
                            if IsDisabledControlJustPressed(Controls.Click.Keys[Index][1], Controls.Click.Keys[Index][2]) then
                                Controls.Click.Pressed = true

                                Citizen.CreateThread(function()
                                    Controls.Click.Active = true

                                    Citizen.Wait(0.01)

                                    Controls.Click.Active = false

                                    Citizen.Wait(174.99)

                                    while Controls.Click.Enabled and IsDisabledControlPressed(Controls.Click.Keys[Index][1], Controls.Click.Keys[Index][2]) do
                                        Controls.Click.Active = true

                                        Citizen.Wait(0.01)

                                        Controls.Click.Active = false

                                        Citizen.Wait(124.99)
                                    end

                                    Controls.Click.Pressed = false
                                end)

                                break
                            end
                        end
                    end
                end
                if Controls.Back.Enabled then
                    for Index = 1, #Controls.Back.Keys do
                        if not Controls.Back.Pressed then
                            if IsDisabledControlJustPressed(Controls.Back.Keys[Index][1], Controls.Back.Keys[Index][2]) then
                                Controls.Back.Pressed = true
                                Wait(10)
                                break
                            end
                        end
                    end
                end

            end
        end
    end
end

---Navigation
---@return nil
---@public
function OnlylifeUI.Navigation()
    if OnlylifeUI.CurrentMenu ~= nil then
        if OnlylifeUI.CurrentMenu() then
            if OnlylifeUI.CurrentMenu.EnableMouse   then
                SetMouseCursorActiveThisFrame()
            end
            if OnlylifeUI.Options > OnlylifeUI.CurrentMenu.Pagination.Total then

                ---@type boolean
                local UpHovered = false

                ---@type boolean
                local DownHovered = false

                if not OnlylifeUI.CurrentMenu.SafeZoneSize then
                    OnlylifeUI.CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }

                    if OnlylifeUI.CurrentMenu.Safezone then
                        OnlylifeUI.CurrentMenu.SafeZoneSize = OnlylifeUI.GetSafeZoneBounds()

                        SetScriptGfxAlign(76, 84)
                        SetScriptGfxAlignParams(0, 0, 0, 0)
                    end
                end

                UpHovered = OnlylifeUI.IsMouseInBounds(OnlylifeUI.CurrentMenu.X + OnlylifeUI.CurrentMenu.SafeZoneSize.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.CurrentMenu.SafeZoneSize.Y + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Height)
                DownHovered = OnlylifeUI.IsMouseInBounds(OnlylifeUI.CurrentMenu.X + OnlylifeUI.CurrentMenu.SafeZoneSize.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Navigation.Rectangle.Height + OnlylifeUI.CurrentMenu.SafeZoneSize.Y + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Height)

                if OnlylifeUI.CurrentMenu.EnableMouse   then


                    if OnlylifeUI.CurrentMenu.Controls.Click.Active then
                        if UpHovered then
                            OnlylifeUI.GoUp(OnlylifeUI.Options)
                        elseif DownHovered then
                            OnlylifeUI.GoDown(OnlylifeUI.Options)
                        end
                    end

                    if UpHovered then
                        RenderRectangle(OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end

                    if DownHovered then
                        RenderRectangle(OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Navigation.Rectangle.Height + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Navigation.Rectangle.Height + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end
                else
                    RenderRectangle(OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    RenderRectangle(OnlylifeUI.CurrentMenu.X, OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Navigation.Rectangle.Height + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Width + OnlylifeUI.CurrentMenu.WidthOffset, OnlylifeUI.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                end
                RenderSprite(OnlylifeUI.Settings.Items.Navigation.Arrows.Dictionary, OnlylifeUI.Settings.Items.Navigation.Arrows.Texture, OnlylifeUI.CurrentMenu.X + OnlylifeUI.Settings.Items.Navigation.Arrows.X + (OnlylifeUI.CurrentMenu.WidthOffset / 2), OnlylifeUI.CurrentMenu.Y + OnlylifeUI.Settings.Items.Navigation.Arrows.Y + OnlylifeUI.CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, OnlylifeUI.Settings.Items.Navigation.Arrows.Width, OnlylifeUI.Settings.Items.Navigation.Arrows.Height)

                OnlylifeUI.ItemOffset = OnlylifeUI.ItemOffset + (OnlylifeUI.Settings.Items.Navigation.Rectangle.Height * 2)

            end
        end
    end
end

---GoBack
---@return nil
---@public
function OnlylifeUI.GoBack()
    if OnlylifeUI.CurrentMenu ~= nil then
        local Audio = OnlylifeUI.Settings.Audio
        OnlylifeUI.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
        if OnlylifeUI.CurrentMenu.Parent ~= nil then
            if OnlylifeUI.CurrentMenu.Parent() then
                OnlylifeUI.NextMenu = OnlylifeUI.CurrentMenu.Parent
            else
                OnlylifeUI.NextMenu = nil
                OnlylifeUI.Visible(OnlylifeUI.CurrentMenu, false)
            end
        else
            OnlylifeUI.NextMenu = nil
            OnlylifeUI.Visible(OnlylifeUI.CurrentMenu, false)
        end
    end
end
