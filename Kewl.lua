
local Themes = {
	Default = {
		Background = Color3.fromRGB(36, 36, 36),
		MainBackground = Color3.fromRGB(24, 24, 24),
		
		BackgroundTab = Color3.fromRGB(24, 24, 24),
		UnselectedTab = Color3.fromRGB(200,200,200),
		SelectedTab = Color3.fromRGB(255, 255, 255),
		
		Button = Color3.fromRGB(38,38,38),
		ButtonHover = Color3.fromRGB(51,51,51),
		
		BackgroundToggle = Color3.fromRGB(36,36,36),
		Toggle = Color3.fromRGB(38,38,38),
		ToggleHover = Color3.fromRGB(54,54,54),
		
		TextColor = Color3.fromRGB(36, 36, 36),
	}
}

local CurrentTheme = Themes["Default"]

local parentGui = gethui and gethui() or (syn and syn.protect_gui and CoreGui)
local TweenService = game:GetService("TweenService")
local function ripple(obj)
	spawn(
		function()
			local Mouse = game.Players.LocalPlayer:GetMouse()
			local Circle = Instance.new("ImageLabel")
			Circle.Name = "Circle"
			Circle.Parent = obj
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Circle.BackgroundTransparency = 1.000
			Circle.ZIndex = 10
			Circle.Image = "rbxassetid://266543268"
			Circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
			Circle.ImageTransparency = 0.4
			local NewX, NewY = Mouse.X - Circle.AbsolutePosition.X, Mouse.Y - Circle.AbsolutePosition.Y
			Circle.Position = UDim2.new(0, NewX, 0, NewY)
			local Size = 0
			if obj.AbsoluteSize.X > obj.AbsoluteSize.Y then
				Size = obj.AbsoluteSize.X * 1.5
			elseif obj.AbsoluteSize.X < obj.AbsoluteSize.Y then
				Size = obj.AbsoluteSize.Y * 1.5
			elseif obj.AbsoluteSize.X == obj.AbsoluteSize.Y then
				Size = obj.AbsoluteSize.X * 1.5
			end
			Circle:TweenSizeAndPosition(
				UDim2.new(0, Size, 0, Size),
				UDim2.new(0.5, -Size / 2, 0.5, -Size / 2),
				"Out",
				"Quad",
				0.2,
				false
			)
			for i = 1, 20 do
				Circle.ImageTransparency = Circle.ImageTransparency + 0.05
				wait(0.3 / 10)
			end
			Circle:Destroy()
		end
	)
end

local function draggable(obj)
	local UserInputService = game:GetService("UserInputService")

	local gui = obj

	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		local EndPos =
			UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		local Tween = TweenService:Create(gui, TweenInfo.new(0.2), {Position = EndPos})
		Tween:Play()
	end

	gui.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = gui.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end
				)
			end
		end
	)

	gui.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
			then
				dragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end
	)
end

local lib = {}

function lib:Window(text)
	local ft = false
	local vistab = true
	local mini = false

	local GUI = Instance.new("ScreenGui")
	local mainframe = Instance.new("Frame")
	local mainholder = Instance.new("Frame")
	local containers = Instance.new("Folder")
	local tabholder = Instance.new("Frame")
	local tablist = Instance.new("UIListLayout")
	local top = Instance.new("Frame")
	local title = Instance.new("TextLabel")
	local minimize = Instance.new("ImageButton")
	
	GUI.Name = "GUI"
	GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	if syn and syn.protect_gui then
		syn.protect_gui(GUI)
	end
	
	if parentGui then
		GUI.Parent = parentGui	
		for _, interface in ipairs(parentGui:GetChildren()) do
			if interface:IsA("ScreenGui") and interface.Name == GUI.Name and interface ~= GUI then
				interface.Enabled = false
			end
		end
	end
	
	mainframe.Name = "mainframe"
	mainframe.Parent = GUI
	mainframe.BackgroundColor3 = CurrentTheme.Background
	mainframe.BorderSizePixel = 0
	mainframe.ClipsDescendants = true
	mainframe.Position = UDim2.new(.5, 0, .5, 0)
	mainframe.AnchorPoint = Vector2.new(.5, .5)
	mainframe.Size = UDim2.new(0, 325, 0, 216)
	draggable(mainframe)

	mainholder.Name = "mainholder"
	mainholder.Parent = mainframe
	mainholder.BackgroundColor3 = CurrentTheme.MainBackground
	mainholder.BorderSizePixel = 0
	mainholder.Position = UDim2.new(0, 0, -0.00381628261, 0)
	mainholder.Size = UDim2.new(0, 396, 0, 27)

	containers.Name = "containers"
	containers.Parent = mainholder

	tabholder.Name = "tabholder"
	tabholder.Parent = mainholder
	tabholder.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	tabholder.BackgroundTransparency = 1.000
	tabholder.BorderSizePixel = 0
	tabholder.Position = UDim2.new(0.023, 0, 1.33703697, 0)
	tabholder.Size = UDim2.new(0, 377, 0, 21)

	tablist.Name = "tablist"
	tablist.Parent = tabholder
	tablist.FillDirection = Enum.FillDirection.Horizontal
	tablist.SortOrder = Enum.SortOrder.LayoutOrder

	top.Name = "top"
	top.Parent = mainholder
	top.BackgroundColor3 = CurrentTheme.MainBackground
	top.BorderSizePixel = 0
	top.Position = UDim2.new(0, 0, -0.00381628261, 0)
	top.Size = UDim2.new(0, 396, 0, 27)

	minimize.Name = "minimize"
	minimize.Parent = top
	minimize.BackgroundTransparency = 1.000
	minimize.LayoutOrder = 6
	minimize.Position = UDim2.new(0.931818187, 0, 0.111111112, 0)
	minimize.Size = UDim2.new(0, 20, 0, 20)
	minimize.ZIndex = 2
	minimize.Image = "rbxassetid://3926307971"
	minimize.ImageRectOffset = Vector2.new(884, 284)
	minimize.ImageRectSize = Vector2.new(36, 36)

	title.Name = "title"
	title.Parent = top
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1.000
	title.BorderSizePixel = 0
	title.Position = UDim2.new(0.0227272734, 0, 0.0364662446, 0)
	title.Size = UDim2.new(0, 42, 0, 26)
	title.Font = Enum.Font.Code
	title.Text = text
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 15.000
	title.TextXAlignment = Enum.TextXAlignment.Left

	minimize.MouseButton1Click:Connect(
		function()
			if mini == false then
				mainframe:TweenSize(UDim2.new(0, 396, 0, 27), "Out", "Quad", 0.25)
				mini = not mini
			else
				mainframe:TweenSize(UDim2.new(0, 396, 0, 231), "In", "Quad", 0.25)
				mini = not mini
			end
		end
	)

	local tabs = {}

	function tabs:Tab(title)
		local tabbtn = Instance.new("TextButton")
		local containerpadding = Instance.new("UIPadding")
		local container = Instance.new("ScrollingFrame")
		local containerlist = Instance.new("UIListLayout")
		tabbtn.Name = "tabbtn"
		tabbtn.Parent = tabholder
		tabbtn.BackgroundColor3 = CurrentTheme.BackgroundTab
		tabbtn.BorderSizePixel = 0
		tabbtn.BackgroundTransparency = 0
		tabbtn.AutoButtonColor = false
		tabbtn.Font = Enum.Font.Code
		tabbtn.Text = title
		tabbtn.TextColor3 = CurrentTheme.UnselectedTab
		tabbtn.TextSize = 14.000
		tabbtn.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
		tabbtn.Size = UDim2.new(0, tabbtn.TextBounds.X + 15, 0, 21)

		container.Name = "container"
		container.Parent = containers
		container.Active = true
		container.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
		container.BorderSizePixel = 0
		container.Position = UDim2.new(0.0227272734, 0, 2.11481524, 0)
		container.Size = UDim2.new(1, -90, 0, 154)
		container.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		container.CanvasSize = UDim2.new(0, 0, 0, 0)
		container.ScrollBarThickness = 3
		container.Visible = vistab
		container.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

		containerpadding.Name = "containerpadding"
		containerpadding.Parent = container
		containerpadding.PaddingLeft = UDim.new(0, 6)
		containerpadding.PaddingTop = UDim.new(0, 6)

		containerlist.Name = "containerlist"
		containerlist.Parent = container
		containerlist.SortOrder = Enum.SortOrder.LayoutOrder
		containerlist.Padding = UDim.new(0, 3)	
		containerlist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		    container.CanvasSize = UDim2.new(0, 0, 0, containerlist.AbsoluteContentSize.X)
		end)

		if ft == false then
			ft = true
			vistab = false
			tabbtn.BackgroundTransparency = 0
		end

		tabbtn.MouseButton1Click:Connect(
			function()
				for i, v in next, containers:GetChildren() do
					if v.Name == "container" then
						v.Visible = false
					end
				end
				for i, v in next, tabholder:GetChildren() do
					if v.ClassName == "TextButton" then
						v.TextColor3 = CurrentTheme.UnselectedTab
					end
				end
				tabbtn.TextColor3 = CurrentTheme.SelectedTab
				container.Visible = true
			end
		)

		local tab = {}
		
		function tab:Label(text)
			
			local Frame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local button = Instance.new("TextLabel")
			
				
			Frame.Name = "Label"
			Frame.BackgroundColor3 = CurrentTheme.Button
			Frame.BackgroundTransparency = 1
			Frame.Parent = container
			
		    UICorner.CornerRadius = UDim.new(0, 4)
		    UICorner.Parent = Frame
			
			button.Name = "Title"
			button.Parent = Frame
			button.BackgroundTransparency = 1
			button.BorderSizePixel = 0
			button.Font = Enum.Font.Code
			button.Text = text
			button.TextColor3 = Color3.fromRGB(255, 255, 255)
			button.TextSize = 14.000
			button.Size = UDim2.new(1, 0, 1, 0)
			button.ClipsDescendants = true
			Frame.Size = UDim2.new(0, button.TextBounds.X + 15, 0, 28)
			
			local change = {}
			function change:Set(text)
				button.Text = tostring(text)
			end
		end

		function tab:Button(text, callback)
			callback = callback or function(...)
			end
			
			local Frame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local button = Instance.new("TextButton")
			
				
			Frame.Name = "Button"
			Frame.BackgroundColor3 = CurrentTheme.Button
			Frame.Parent = container
			
		    UICorner.CornerRadius = UDim.new(0, 4)
		    UICorner.Parent = Frame
			
			button.Name = "Interaction"
			button.Parent = Frame
			button.BackgroundTransparency = 1
			button.BorderSizePixel = 0
			button.AutoButtonColor = false
			button.Font = Enum.Font.Code
			button.Text = text
			button.TextColor3 = Color3.fromRGB(255, 255, 255)
			button.TextSize = 14.000
			button.Size = UDim2.new(1, 0, 1, 0)
			button.ClipsDescendants = true
			Frame.Size = UDim2.new(0, button.TextBounds.X + 15, 0, 28)

			button.MouseEnter:Connect(function()
				TweenService:Create(Frame,TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundColor3 = CurrentTheme.ButtonHover}):Play()
			end)
			button.MouseLeave:Connect(function()
				TweenService:Create(Frame,TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundColor3 = CurrentTheme.Button}):Play()
			end)

			button.MouseButton1Click:Connect(
				function()
					ripple(button)
					pcall(callback)
				end
			)
		end

		function tab:Toggle(text, default, callback)
			local state = default
		
			local Frame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local toggle = Instance.new("TextButton")
			local title = Instance.new("TextLabel")
			local backgroundstatus = Instance.new("Frame")
			local status = Instance.new("Frame")
		
			Frame.Name = "Toggle"
			Frame.BackgroundColor3 = CurrentTheme.Toggle
			Frame.Parent = container
		
			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Frame
		
			toggle.Name = "Interaction"
			toggle.Parent = Frame
			toggle.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			toggle.BorderSizePixel = 0
			toggle.ClipsDescendants = true
			toggle.BackgroundTransparency = 1
			toggle.AutoButtonColor = false
			toggle.Font = Enum.Font.SourceSans
			toggle.Text = ""
			toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			toggle.TextSize = 14
			toggle.Size = UDim2.new(1, 0, 1, 0)
		
			title.Name = "title"
			title.Parent = toggle
			title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title.BackgroundTransparency = 1
			title.BorderSizePixel = 0
			title.Position = UDim2.new(0, 40, 0, 0)
			title.Font = Enum.Font.Code
			title.Text = text
			title.Size = UDim2.new(1, 0, 1, 0)
			title.TextColor3 = Color3.fromRGB(255, 255, 255)
			title.TextSize = 14
			title.TextXAlignment = Enum.TextXAlignment.Left
		
			Frame.Size = UDim2.new(0, title.TextBounds.X + 56, 0, 30)
		
			backgroundstatus.Name = "backgroundstatus"
			backgroundstatus.Parent = toggle
			backgroundstatus.AnchorPoint = Vector2.new(0, 0.5)
			backgroundstatus.BackgroundColor3 = CurrentTheme.BackgroundToggle
			backgroundstatus.BorderSizePixel = 0
			backgroundstatus.Position = UDim2.new(0.005, 8, 0.5, 0)
			backgroundstatus.Size = UDim2.new(0, 18, 0, 18)
			
			local Corner = UICorner:Clone()
			Corner.CornerRadius = UDim.new(0, 2)
			Corner.Parent = backgroundstatus
			
			status.Name = "status"
			status.Parent = backgroundstatus
			status.AnchorPoint = Vector2.new(0.5, 0.5)
			status.BackgroundColor3 = CurrentTheme.ToggleHover
			status.BorderSizePixel = 0
			status.BackgroundTransparency = state and 0 or 1
			status.Position = UDim2.new(0.5, 0, 0.5, 0)
			status.Size = UDim2.new(0, 15, 0, 15)
			UICorner:Clone().Parent = status
		
			local function updateToggle()
				TweenService:Create(status, TweenInfo.new(0.2), {BackgroundTransparency = state and 0 or 1}):Play()
				pcall(callback, state)
			end
		
			toggle.MouseButton1Click:Connect(function()
				state = not state
				updateToggle()
				ripple(toggle)
			end)
		
			updateToggle()
		end

		function tab:Slider(text, min, max, start, callback)
			local inputService = game:GetService("UserInputService")
			local slider = Instance.new("Frame")
			local title = Instance.new("TextLabel")
			local placetoslide = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local slideframe = Instance.new("Frame")
			local value = Instance.new("TextLabel")
			local dragging = false

			slider.Name = "slider"
			slider.Parent = container
			slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			slider.BackgroundTransparency = 1.000
			slider.Position = UDim2.new(0.503712893, 0, 0.239035085, 0)

			title.Name = "title"
			title.Parent = slider
			title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title.BackgroundTransparency = 1.000
			title.BorderSizePixel = 0
			title.Position = UDim2.new(0, 6, 0, 0)
			title.Size = UDim2.new(0, 23, 0, 24)
			title.ZIndex = 2
			title.Font = Enum.Font.Gotham
			title.Text = text
			title.TextColor3 = Color3.fromRGB(255, 255, 255)
			title.TextSize = 14.000
			title.TextXAlignment = Enum.TextXAlignment.Left
			slider.Size = UDim2.new(0, title.TextBounds.X + 185, 0, 36)

			placetoslide.Name = "placetoslide"
			placetoslide.Parent = slider
			placetoslide.AnchorPoint = Vector2.new(0, 0.5)
			placetoslide.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
			placetoslide.BorderSizePixel = 0
			placetoslide.Position = UDim2.new(0, 5, 1, -8)
			placetoslide.Size = UDim2.new(0, 146, 0, 16)
			placetoslide.AutoButtonColor = false
			placetoslide.Text = ""
			
			UICorner.CornerRadius = UDim.new(0, 4)
		    UICorner.Parent = placetoslide

			slideframe.Name = "slideframe"
			slideframe.Parent = placetoslide
			slideframe.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			slideframe.BorderSizePixel = 0
			slideframe.Size = UDim2.new((start or 0) / max, 0, 1, 0)

			value.Name = "value"
			value.Parent = placetoslide
			value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			value.BackgroundTransparency = 1.000
			value.BorderSizePixel = 0
			value.Size = UDim2.new(1, 0, 1, 0)
			value.Font = Enum.Font.Gotham
			value.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
			value.TextColor3 = Color3.fromRGB(255, 255, 255)
			value.TextSize = 14.000
			container.CanvasSize = UDim2.new(0, 0, 0, containerlist.AbsoluteContentSize.Y + 10)

			local function slide(input)
				local pos =
					UDim2.new(
						math.clamp((input.Position.X - placetoslide.AbsolutePosition.X) / placetoslide.AbsoluteSize.X, 0, 1),
						0,
						1,
						0
					)
				slideframe:TweenSize(pos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
				local s = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
				value.Text = tostring(s)
				callback(s)
			end

			placetoslide.InputBegan:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						slide(input)
						dragging = true
					end
				end
			)

			placetoslide.InputEnded:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end
			)

			inputService.InputChanged:Connect(
				function(input)
					if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						slide(input)
					end
				end
			)
		end

		function tab:Dropdown(text, list, default, callback)
			list = list or {}
			default = default or list[1]
			local d = false
			callback = callback or function(...)
			end
			local dropdown = Instance.new("Frame")
			local title = Instance.new("TextLabel")
			local value = Instance.new("TextButton")
			local arrow = Instance.new("ImageButton")
			local dropdowncontainer = Instance.new("ScrollingFrame")
			local dropdownlist = Instance.new("UIListLayout")
			
			local interaction = Instance.new("TextButton")

			dropdown.Name = "dropdown"
			dropdown.Parent = container
			dropdown.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			dropdown.BorderSizePixel = 0
			dropdown.Position = UDim2.new(0.295454532, 0, 0.36796537, 0)
			dropdown.Size = UDim2.new(0, 200, 0, 36)
			dropdown.BackgroundTransparency = 1
			dropdown.ClipsDescendants = false

			local closetween =
				TweenService:Create(
					arrow,
					TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
					{
						Rotation = 90
					}
				)
			local opentween =
				TweenService:Create(
					arrow,
					TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
					{
						Rotation = 0
					}
				)

			title.Name = "title"
			title.Parent = dropdown
			title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title.BackgroundTransparency = 1.000
			title.BorderSizePixel = 0
			title.Position = UDim2.new(0, 8, 0, 0)
			title.Size = UDim2.new(0, 23, 0, 24)
			title.Font = Enum.Font.Code
			title.Text = text
			title.TextColor3 = Color3.fromRGB(255, 255, 255)
			title.TextSize = 14.000
			title.TextXAlignment = Enum.TextXAlignment.Left
			
			value.Name = "value"
			value.Parent = dropdown
			value.AnchorPoint = Vector2.new(0, 0.5)
			value.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
			value.BorderSizePixel = 0
			value.Font = Enum.Font.Code
			value.Position = UDim2.new(0, 5, 1, -8)
			value.Size = UDim2.new(0, 146, 0, 16)
			value.AutoButtonColor = false
			value.Text = default
			value.TextColor3 = Color3.fromRGB(255,255,255)
			value.TextSize = 12
			value.TextXAlignment = Enum.TextXAlignment.Left
			
			arrow.Name = "arrow"
			arrow.Parent = value
			arrow.BackgroundTransparency = 1.000
			arrow.LayoutOrder = 11
			arrow.Position = UDim2.new(1, -24, 0.166666657, 0)
			arrow.Size = UDim2.new(0, 20, 0, 20)
			arrow.Image = "rbxassetid://4918373417"
			arrow.ImageRectOffset = Vector2.new(564, 284)
			arrow.ImageRectSize = Vector2.new(36, 36)
			arrow.Rotation = 90

			dropdowncontainer.Name = "dropdowncontainer"
			dropdowncontainer.Parent = dropdown
			dropdowncontainer.Active = true
			dropdowncontainer.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
			dropdowncontainer.BorderSizePixel = 0
			dropdowncontainer.ZIndex = 2
			dropdowncontainer.Position = UDim2.new(0, 5, 1, -8)
			dropdowncontainer.Size = UDim2.new(0, 146, 0, 16)
			dropdowncontainer.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
			dropdowncontainer.CanvasSize = UDim2.new(0, 0, 0, 0)
			dropdowncontainer.ScrollBarThickness = 3
			dropdowncontainer.Visible = false
			dropdowncontainer.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

			dropdownlist.Name = "dropdownlist"
			dropdownlist.Parent = dropdowncontainer
			dropdownlist.SortOrder = Enum.SortOrder.LayoutOrder

			interaction.Name = "interaction"
			interaction.Parent = dropdown
			interaction.BackgroundTransparency = 1
			interaction.Text = ""
			interaction.Size = UDim2.new(1, 0, 1, 0)
			interaction.ClipsDescendants = true

			interaction.MouseButton1Click:Connect(
				function()
					if d == false then
						d = not d
						opentween:Play()
						dropdowncontainer.Visible = true
						dropdowncontainer:TweenSize(UDim2.new(0, 146, 0, 92), "In", "Quad", 0.25)
						container.CanvasSize = UDim2.new(0, 0, 0, containerlist.AbsoluteContentSize.Y + 105)
					else
						d = not d
						closetween:Play()
						dropdowncontainer:TweenSize(UDim2.new(0, 146, 0, 0), "Out", "Quad", 0.25)
						container.CanvasSize = UDim2.new(0, 0, 0, containerlist.AbsoluteContentSize.Y + 10)
						wait(0.3)
						dropdowncontainer.Visible = false
					end
				end
			)
			container.CanvasSize = UDim2.new(0, 0, 0, containerlist.AbsoluteContentSize.Y + 10)

			for i, v in next, list do
				local option = Instance.new("TextButton")
				option.Name = "option"
				option.Parent = dropdowncontainer
				option.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
				option.BorderSizePixel = 0
				option.Size = UDim2.new(0, 146, 0, 27)
				option.AutoButtonColor = false
				option.Font = Enum.Font.Code
				option.TextColor3 = Color3.fromRGB(255, 255, 255)
				option.TextSize = 14.000
				option.Text = v

				local me =
					TweenService:Create(
						option,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{
							BackgroundColor3 = Color3.fromRGB(49, 49, 49)
						}
					)

				local ml =
					TweenService:Create(
						option,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{
							BackgroundColor3 = Color3.fromRGB(36, 36, 36)
						}
					)

				option.MouseEnter:Connect(
					function()
						me:Play()
					end
				)
				option.MouseLeave:Connect(
					function()
						ml:Play()
					end
				)

				option.MouseButton1Click:Connect(
					function()
						value.Text = v
						callback(v)
						d = not d
						closetween:Play()
						dropdowncontainer:TweenSize(UDim2.new(0, 146, 0, 0), "Out", "Quad", 0.25)
						container.CanvasSize = UDim2.new(0, 0, 0, containerlist.AbsoluteContentSize.Y + 10)
						wait(0.3)
						dropdowncontainer.Visible = false
					end
				)
				dropdowncontainer.CanvasSize = UDim2.new(0, 0, 0, dropdownlist.AbsoluteContentSize.Y)
			end
		end

		function tab:Textbox(text, disapeer, callback)
			callback = callback or function(...)
			end
			local textbox = Instance.new("Frame")
			local title = Instance.new("TextLabel")
			local textboxframe = Instance.new("Frame")
			local textboxmain = Instance.new("TextBox")

			textbox.Name = "textbox"
			textbox.Parent = container
			textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			textbox.BackgroundTransparency = 1.000
			textbox.Position = UDim2.new(0.503712893, 0, 0.239035085, 0)

			title.Name = "title"
			title.Parent = textbox
			title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title.BackgroundTransparency = 1.000
			title.BorderSizePixel = 0
			title.Position = UDim2.new(0, 6, 0, 0)
			title.Size = UDim2.new(0, 23, 1, 0)
			title.Font = Enum.Font.Gotham
			title.Text = text
			title.TextColor3 = Color3.fromRGB(255, 255, 255)
			title.TextSize = 14.000
			title.TextXAlignment = Enum.TextXAlignment.Left
			textbox.Size = UDim2.new(0, title.TextBounds.X + 185, 0, 30)

			textboxframe.Name = "textboxframe"
			textboxframe.Parent = textbox
			textboxframe.AnchorPoint = Vector2.new(1, 0.5)
			textboxframe.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
			textboxframe.BorderSizePixel = 0
			textboxframe.Position = UDim2.new(1, 0, 0.5, 0)
			textboxframe.Size = UDim2.new(0, 165, 0, 26)

			textboxmain.Name = "textboxmain"
			textboxmain.Parent = textboxframe
			textboxmain.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
			textboxmain.BorderSizePixel = 0
			textboxmain.Size = UDim2.new(0, 165, 0, 26)
			textboxmain.Font = Enum.Font.Gotham
			textboxmain.Text = ""
			textboxmain.TextColor3 = Color3.fromRGB(255, 255, 255)
			textboxmain.TextSize = 14.000
			container.CanvasSize = UDim2.new(0, 0, 0, containerlist.AbsoluteContentSize.Y + 10)

			textboxmain.FocusLost:Connect(
				function(ep)
					if ep then
						if #textboxmain.Text > 0 then
							pcall(callback, textboxmain.Text)
							if disapeer then
								textboxmain.Text = ""
							end
						end
					end
				end
			)
		end
		return tab
	end
	return tabs
end

return lib
