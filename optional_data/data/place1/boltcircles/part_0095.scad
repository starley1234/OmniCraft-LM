$fn = 32;

// ----------------------------------------------------------------------
// Flange Ø100 x 15
// 4 holes on a Ø66 bolt circle, bolted joints
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 100;  // outside diameter of the flange
thickness = 15;  // flange thickness
holes = 4;       // number of bolt holes
pcd = 66;        // bolt circle diameter
start_deg = 0;   // angle of the first hole, from +X
hole_d = 6.6;    // bolt hole diameter
bore_d = 15;     // central through bore
hub_d = 27;      // hub outside diameter
hub_h = 0;       // hub height above the flange face (0 = no hub)

// --- derived feature positions (mm) ---
height = thickness + hub_h;  // = 15   overall height of the part
pcd_r = pcd / 2;             // = 33   bolt circle radius
hole_step = 360 / holes;     // = 90   angular pitch
feature_centers = [
  [pcd_r * cos(start_deg + 0 * hole_step), pcd_r * sin(start_deg + 0 * hole_step)],
  [pcd_r * cos(start_deg + 1 * hole_step), pcd_r * sin(start_deg + 1 * hole_step)],
  [pcd_r * cos(start_deg + 2 * hole_step), pcd_r * sin(start_deg + 2 * hole_step)],
  [pcd_r * cos(start_deg + 3 * hole_step), pcd_r * sin(start_deg + 3 * hole_step)]
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
