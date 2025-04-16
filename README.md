# Traffic Light Controller - Verilog Project

## 📌 Project Description
This project simulates a **Traffic Light Controller** using Verilog. The design implements a state machine that controls the behavior of traffic lights based on sensor inputs. The project includes:
- A **Verilog module** (`traffic_light.sv`) for traffic light logic.
- A **Testbench** (`traffic_light_tb.sv`) to verify functionality and generate waveforms.
- Simulation using **EDA Playground** or any Verilog simulator.

## 📁 File Structure
```
📂 Traffic_Light_Controller
├── traffic_light.sv     # Main Verilog design
├── traffic_light_tb.sv  # Testbench for simulation
├── EPWave.png           # Waveform file (generated after simulation)
├── README.md            # Project documentation
```

## 🚦 Traffic Light Logic
- **Inputs:**
  - `clk` (Clock Signal)
  - `Sa` (Sensor A - Indicates traffic presence on Road A)
  - `Sb` (Sensor B - Indicates traffic presence on Road B)
- **Outputs:**
  - `Ra`, `Ga`, `Ya` (Red, Green, Yellow lights for Road A)
  - `Rb`, `Gb`, `Yb` (Red, Green, Yellow lights for Road B)

## 🛠️ Running the Simulation
### 1️⃣ Using EDA Playground
1. Open [EDA Playground](https://www.edaplayground.com/)
2. Select **Icarus Verilog** as the simulator
3. Paste `traffic_light.sv` and `traffic_light_tb.sv` in the respective tabs
4. Enable **Save Waveform** option for EPWave
5. Click **Run**
6. Open **EPWave** to visualize the waveform

### 2️⃣ Running Locally with Icarus Verilog
```sh
iverilog -o traffic_light traffic_light.sv traffic_light_tb.sv
vvp traffic_light
```

## 📊 Expected Console Output
```
Time | Sa Sb | Ra Ga Ya | Rb Gb Yb
Time=0 | Sa=0 Sb=0 | Ra=0 Ga=1 Ya=0 | Rb=1 Gb=0 Yb=0
Time=10000 | Sa=1 Sb=0 | Ra=1 Ga=0 Ya=1 | Rb=1 Gb=0 Yb=0
Time=50000 | Sa=0 Sb=0 | Ra=0 Ga=1 Ya=0 | Rb=1 Gb=0 Yb=0
Time=80000 | Sa=0 Sb=1 | Ra=1 Ga=0 Ya=0 | Rb=1 Gb=0 Yb=1
Time=130000 | Sa=0 Sb=0 | Ra=0 Ga=1 Ya=0 | Rb=1 Gb=0 Yb=0
```

## 📜 License
This project is open-source and free to use for educational purposes.

