---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
    LeftBadge = { Y = -2, Width = 40, Height = 40 },
    RightBadge = { X = 385, Y = -2, Width = 40, Height = 40 },
    RightText = { X = 420, Y = 4, Scale = 0.35 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

---Button
---@param Label string
---@param Description string
---@param Enabled boolean
---@param Callback function
---@param Submenu table
---@return nil
---@public
function OnlylifeUI.Button(Label, Description, Enabled, Callback, Submenu)
    local CurrentMenu = OnlylifeUI.CurrentMenu
    if CurrentMenu ~= nil and CurrentMenu() then
        ---@type number
        local Option = OnlylifeUI.Options + 1

        if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
            ---@type boolean
            local Active = CurrentMenu.Index == Option

            OnlylifeUI.ItemsSafeZone(CurrentMenu)

            if Active then
                RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
            end

            local colorData = Enabled and (Active and { 0, 0, 0 } or { 255, 255, 255 }) or { 163, 159, 148 }
            RenderText(Label, CurrentMenu.X + SettingsButton.Text.X, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, 0, SettingsButton.Text.Scale, colorData[1], colorData[2], colorData[3], 255)

            OnlylifeUI.ItemOffset = OnlylifeUI.ItemOffset + SettingsButton.Rectangle.Height

            OnlylifeUI.ItemsDescription(CurrentMenu, Description, Active);

            if Enabled then
                ---@type boolean
                local Hovered = CurrentMenu.EnableMouse and (CurrentMenu.CursorStyle == 0 or CurrentMenu.CursorStyle == 1) and OnlylifeUI.ItemsMouseBounds(CurrentMenu, Active, Option + 1, SettingsButton);
                local Selected = (CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active)) and Active

                if Callback then
                    Callback(Hovered, Active, Selected)
                end

                if Selected then
                    local Audio = OnlylifeUI.Settings.Audio
                    OnlylifeUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)

                    if Submenu and Submenu() then
                        OnlylifeUI.NextMenu = Submenu
                    end
                end
            end
        end

        OnlylifeUI.Options = OnlylifeUI.Options + 1
    end
end

---ButtonWithStyle
---@param Label string
---@param Description string
---@param Style table
---@param Enabled boolean
---@param Callback function
---@param Submenu table
---@return nil
---@public
function OnlylifeUI.ButtonWithStyle(Label, Description, Style, Enabled, Callback, Submenu)
    local CurrentMenu = OnlylifeUI.CurrentMenu
    if CurrentMenu ~= nil and CurrentMenu() then
        ---@type number
        local Option = OnlylifeUI.Options + 1

        if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
            ---@type boolean
            local Active = CurrentMenu.Index == Option

            OnlylifeUI.ItemsSafeZone(CurrentMenu)

            local haveLeftBadge = Style.LeftBadge and Style.LeftBadge ~= OnlylifeUI.BadgeStyle.None
            local haveRightBadge = (Style.RightBadge and Style.RightBadge ~= OnlylifeUI.BadgeStyle.None) or (not Enabled and Style.LockBadge ~= OnlylifeUI.BadgeStyle.None)

            local LeftBadgeOffset = haveLeftBadge and 27 or 0
            local RightBadgeOffset = haveRightBadge and 32 or 0

            if Style.Color and Style.Color.BackgroundColor then
                RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height, Style.Color.BackgroundColor[1], Style.Color.BackgroundColor[2], Style.Color.BackgroundColor[3])
            end

            if Active then
                if Style.Color and Style.Color.HightLightColor then
                    RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height, Style.Color.HightLightColor[1], Style.Color.HightLightColor[2], Style.Color.HightLightColor[3])
                else
                    RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
                end
            end

            if Enabled then
                if haveLeftBadge then
                    local LeftBadge = Style.LeftBadge(Active)
                    RenderSprite(LeftBadge.BadgeDictionary or "commonmenu", LeftBadge.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, LeftBadge.BadgeColour and LeftBadge.BadgeColour.R or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.G or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.B or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.A or 255)
                end

                if haveRightBadge then
                    local RightBadge = Style.RightBadge(Active)
                    RenderSprite(RightBadge.BadgeDictionary or "commonmenu", RightBadge.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255)
                end

                if Style.RightLabel then
                    RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, 0, SettingsButton.RightText.Scale, Active and 0 or 245, Active and 0 or 245, Active and 0 or 245, 255, 2)
                end

                RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, 0, SettingsButton.Text.Scale, Active and 0 or 245, Active and 0 or 245, Active and 0 or 245, 255)
            else
                if haveRightBadge then
                    local RightBadge = OnlylifeUI.BadgeStyle.Lock(Active)
                    RenderSprite(RightBadge.BadgeDictionary or "commonmenu", RightBadge.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255)
                end

                RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + OnlylifeUI.ItemOffset, 0, SettingsButton.Text.Scale, 163, 159, 148, 255)
            end

            OnlylifeUI.ItemOffset = OnlylifeUI.ItemOffset + SettingsButton.Rectangle.Height

            OnlylifeUI.ItemsDescription(CurrentMenu, Description, Active);

            if Enabled then
                ---@type boolean
                local Hovered = CurrentMenu.EnableMouse and (CurrentMenu.CursorStyle == 0 or CurrentMenu.CursorStyle == 1) and OnlylifeUI.ItemsMouseBounds(CurrentMenu, Active, Option + 1, SettingsButton);
                local Selected = (CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active)) and Active

                if Callback then
                    Callback(Hovered, Active, Selected)
                end

                if Selected then
                    local Audio = OnlylifeUI.Settings.Audio
                    OnlylifeUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)

                    if Submenu and Submenu() then
                        OnlylifeUI.NextMenu = Submenu
                    end
                end
            end

        end

        OnlylifeUI.Options = OnlylifeUI.Options + 1
    end
end