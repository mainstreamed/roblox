local cp = function(pos)
      local p = Instance.new('Part', workspace);
      p.Position = pos;
      p.Anchored = true;
      p.Size = Vector3.new(0.1, 0.1, 0.1);
      p.CanCollide = false;
      Instance.new('Highlight', p)
      task.delay(3, function()
            p:Destroy();
      end)

end;

local targets = {
      'Cactus1';
      'Cactus2';
};

local entityList = getrenv()._G.classes.EntityClient.EntityMap;
local runservice  = game:GetService('RunService');


local camera      = workspace.CurrentCamera;

local funcs = {
      Cactus2 = function(model)
            local base = model.PrimaryPart.CFrame;


            local offsets = {
                  base.Position;
                  (base*CFrame.new(0.2, 3.9, 0)).Position;

                  (base*CFrame.new(1.8, 4.1, 1)).Position;
                  (base*CFrame.new(2.1, 4.4, 1.1)).Position;

                  (base*CFrame.new(0.15, 5.2, 0.1)).Position;
                  (base*CFrame.new(-1.8, 5.4, -0.2)).Position;
                  (base*CFrame.new(-2.3, 6.35, -0.4)).Position;

                  (base*CFrame.new(0.1, 9.5, 0)).Position;
            };
            local drawings = {};
            for i = 1, 7 do
                  local drawing = Drawing.new('Line');
                  drawing.Thickness = 1;
                  drawing.Visible = false;
                  drawing.Color = Color3.new(1, 1, 1);
                  table.insert(drawings, drawing);
            end;

            local hidedrawings = function()
                  for i = 1, #drawings do
                        drawings[i].Visible = false;
                  end;
            end;


            local connection1, connection2;

            connection1 = runservice.RenderStepped:Connect(function()
                  local points = {};
                  for i = 1, #offsets do
                        local vector3 = offsets[i];
                        local point, os = camera:WorldToViewportPoint(vector3);
                        if (not os) then
                              return hidedrawings();
                        end;
                        points[i] = Vector2.new(point.X, point.Y);
                  end;

                  for i = 1, #drawings do
                        drawings[i].Visible = true;
                  end;
                  
                  drawings[1].From = points[1];
                  drawings[1].To = points[2];

                  drawings[2].From = points[2];
                  drawings[2].To = points[3];

                  drawings[3].From = points[3];
                  drawings[3].To = points[4];

                  drawings[4].From = points[2];
                  drawings[4].To = points[5];

                  drawings[5].From = points[5];
                  drawings[5].To = points[6];

                  drawings[6].From = points[6];
                  drawings[6].To = points[7];

                  drawings[7].From = points[5];
                  drawings[7].To = points[8];
            end);


            connection2 = model.AncestryChanged:Connect(function()
                  connection1:Disconnect();
                  for i = 1, #drawings do
                        drawings[i]:Remove();
                  end;
                  connection2:Disconnect();
            end);
      end;


};

local distance = 30;
local target;

for i, v in pairs(entityList) do
      if (v.type == 'Cactus2') then
            funcs.Cactus2(v.model)
      end;
      -- if (table.find(targets, rawget(v, 'type'))) then
      --       local dis2 = (rawget(v, 'pos') - workspace.CurrentCamera.CFrame.Position).Magnitude;
      --       if (dis2 < distance) then
      --             distance = dis2;
      --             target = v;
      --       end;
      -- end;
end;
