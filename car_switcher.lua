-- MotorsportRR Quick Car Switcher
-- F7 = open/close
-- Up/Down = select
-- Enter = switch car

local cars = {
  { name = 'Renault Clio 4 GT Line', id = 'acdz_clio_4_gt_line' },
  { name = 'Dacia Stepway', id = 'acdz_ramy_dacia_stepway' },
  { name = 'VW Golf 7.5 R', id = 'acdz_ramy_vw_golf_75r' },
  { name = 'VW Golf R 2022', id = 'acdz_ramy_golf_r_2022' },
  { name = 'VW Polo 2018', id = 'acdz_ramy_polo_2018' },
  { name = 'Audi S3', id = 'acdz_ramy_audi_s3' },
  { name = 'VW Golf 6 R20', id = 'acdz_ramy_vw_golf_6_r20' },
  { name = 'Mercedes-AMG A45 S', id = 'acdz_ramy_mercedes_a45s' },
  { name = 'SEAT Ibiza', id = 'acdz_ramy_seat_ibiza' },
  { name = 'VW Polo 1.6 TDI', id = 'acdz_ramy_polo_1.6_tdi' },
  { name = 'Cupra 2015 V2', id = 'acdz_ramy_cupra_2015_v2' },
  { name = 'Renault Clio RS Line', id = 'ramy_clio_rsline' },
  { name = 'Peugeot 208 2023', id = 'ramy_peugeot_208_2023' },
  { name = 'Skoda Octavia 2019', id = 'ramy_skoda_octavia_2019' },
  { name = 'VW Tiguan R-Line', id = 'ramy_volkswagen_tiguan_rline' },
  { name = 'Fiat Tipo Life', id = 'ramy_fiat_tipo_life' },
  { name = 'MG5 2025', id = 'ramy_mg5_2025' },
  { name = 'VW Tharu XR', id = 'ramy_vw_tharu_xr' },
  { name = 'Kia Rio 2019', id = 'ramy_kia_rio_2019' },
}

local selected = 1
local opened = false

local f7WasDown = false
local upWasDown = false
local downWasDown = false
local enterWasDown = false

local function switchCar()
  local selectedCar = cars[selected]

  if not selectedCar then
    return
  end

  ac.reconnectTo({
    serverIP = '154.252.104.157',
    serverPort = 9606,
    serverHttpPort = 8086,
    carID = selectedCar.id
  })
end

function script.update(dt)

  local f7 = ac.isKeyDown(ac.KeyIndex.F7)
  local up = ac.isKeyDown(ac.KeyIndex.Up)
  local down = ac.isKeyDown(ac.KeyIndex.Down)
  local enter = ac.isKeyDown(ac.KeyIndex.Enter)

  -- F7: open/close
  if f7 and not f7WasDown then
    opened = not opened
  end

  if opened then

    -- UP: previous car
    if up and not upWasDown then
      selected = selected - 1

      if selected < 1 then
        selected = #cars
      end
    end

    -- DOWN: next car
    if down and not downWasDown then
      selected = selected + 1

      if selected > #cars then
        selected = 1
      end
    end

    -- ENTER: reconnect with selected car
    if enter and not enterWasDown then
      switchCar()
    end

  end

  f7WasDown = f7
  upWasDown = up
  downWasDown = down
  enterWasDown = enter
end

function script.drawUI()

  if not opened then
    ui.text('F7 - Change Car')
    return
  end

  ui.text('MOTORSPORTRR - QUICK CAR SWITCH')
  ui.separator()

  ui.text('UP / DOWN = Select')
  ui.text('ENTER = Switch Car')
  ui.text('F7 = Close')

  ui.separator()

  for i, item in ipairs(cars) do

    if i == selected then
      ui.text('> ' .. item.name .. ' <')
    else
      ui.text('  ' .. item.name)
    end

  end

  ui.separator()

  local selectedCar = cars[selected]

  ui.text('Selected:')
  ui.text(selectedCar.name)
  ui.text('ID: ' .. selectedCar.id)

  ui.separator()
  ui.text('Press ENTER to switch')
end
