$fn = 32;

// ----------------------------------------------------------------------
// Flange Ø50 x 6
// 10 holes on a Ø33 bolt circle, bolted joints
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 50;   // outside diameter of the flange
thickness = 6;   // flange thickness
holes = 10;      // number of bolt holes
pcd = 33;        // bolt circle diameter
start_deg = 15;  // angle of the first hole, from +X
hole_d = 5.5;    // bolt hole diameter
bore_d = 19.5;   // central through bore
hub_d = 31.5;    // hub outside diameter
hub_h = 10;      // hub height above the flange face (0 = no hub)

// --- derived feature positions (mm) ---
height = thickness + hub_h;  // = 16   overall height of the part
pcd_r = pcd / 2;             // = 16.5   bolt circle radius
hole_step = 360 / holes;     // = 36   angular pitch
feature_centers = [
  [pcd_r * cos(start_deg + 0 * hole_step), pcd_r * sin(start_deg + 0 * hole_step)],
  [pcd_r * cos(start_deg + 1 * hole_step), pcd_r * sin(start_deg + 1 * hole_step)],
  [pcd_r * cos(start_deg + 2 * hole_step), pcd_r * sin(start_deg + 2 * hole_step)],
  [pcd_r * cos(start_deg + 3 * hole_step), pcd_r * sin(start_deg + 3 * hole_step)],
  [pcd_r * cos(start_deg + 4 * hole_step), pcd_r * sin(start_deg + 4 * hole_step)],
  [pcd_r * cos(start_deg + 5 * hole_step), pcd_r * sin(start_deg + 5 * hole_step)],
  [pcd_r * cos(start_deg + 6 * hole_step), pcd_r * sin(start_deg + 6 * hole_step)],
  [pcd_r * cos(start_deg + 7 * hole_step), pcd_r * sin(start_deg + 7 * hole_step)],
  [pcd_r * cos(start_deg + 8 * hole_step), pcd_r * sin(start_deg + 8 * hole_step)],
  [pcd_r * cos(start_deg + 9 * hole_step), pcd_r * sin(start_deg + 9 * hole_step)]
];   // bolt hole centres on the pitch circle

// flange disc, every hole and the bore cut straight through
difference() {
  union() {
    cylinder(d = flange_d, h = thickness);
    cylinder(d = hub_d, h = height);  // hub, overlapped into the flange
  }
  translate([0, 0, -1]) cylinder(d = bore_d, h = height + 2);  // bore, through
  for (centre = feature_centers)
    translate([centre[0], centre[1], -1]) cylinder(d = hole_d, h = thickness + 2);
}
