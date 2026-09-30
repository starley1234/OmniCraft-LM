$fn = 32;

// ----------------------------------------------------------------------
// Flange Ø120 x 10
// 8 holes on a Ø88.8 bolt circle, bolted joints
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 120;    // outside diameter of the flange
thickness = 10;    // flange thickness
holes = 8;         // number of bolt holes
pcd = 88.8;        // bolt circle diameter
start_deg = 22.5;  // angle of the first hole, from +X
hole_d = 3.4;      // bolt hole diameter
bore_d = 38;       // central through bore
hub_d = 46;        // hub outside diameter
hub_h = 0;         // hub height above the flange face (0 = no hub)

// --- derived feature positions (mm) ---
height = thickness + hub_h;  // = 10   overall height of the part
pcd_r = pcd / 2;             // = 44.4   bolt circle radius
hole_step = 360 / holes;     // = 45   angular pitch
feature_centers = [
  [pcd_r * cos(start_deg + 0 * hole_step), pcd_r * sin(start_deg + 0 * hole_step)],
  [pcd_r * cos(start_deg + 1 * hole_step), pcd_r * sin(start_deg + 1 * hole_step)],
  [pcd_r * cos(start_deg + 2 * hole_step), pcd_r * sin(start_deg + 2 * hole_step)],
  [pcd_r * cos(start_deg + 3 * hole_step), pcd_r * sin(start_deg + 3 * hole_step)],
  [pcd_r * cos(start_deg + 4 * hole_step), pcd_r * sin(start_deg + 4 * hole_step)],
  [pcd_r * cos(start_deg + 5 * hole_step), pcd_r * sin(start_deg + 5 * hole_step)],
  [pcd_r * cos(start_deg + 6 * hole_step), pcd_r * sin(start_deg + 6 * hole_step)],
  [pcd_r * cos(start_deg + 7 * hole_step), pcd_r * sin(start_deg + 7 * hole_step)]
];   // bolt hole centres on the pitch circle

// flange disc, every hole and the bore cut straight through
difference() {
  union() {
    cylinder(d = flange_d, h = thickness);
  }
  translate([0, 0, -1]) cylinder(d = bore_d, h = height + 2);  // bore, through
  for (centre = feature_centers)
    translate([centre[0], centre[1], -1]) cylinder(d = hole_d, h = thickness + 2);
}
