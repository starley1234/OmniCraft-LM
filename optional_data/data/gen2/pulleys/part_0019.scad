$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: HTD5 24T, pitch 5 mm, 40.6 mm x 19 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pitch = 5;                // belt pitch
teeth = 24;               // number of grooves
belt_w = 9;               // belt width between the flanges
tip_d = 37.6;             // tip circle diameter
root_d = 35.4;            // groove bottom diameter
groove_h = 1.1;           // groove depth
tooth_w = 3.2;            // groove width at the tip circle
flange_d = 40.6;          // flange diameter
flange_t = 2;             // flange thickness
spigot_d = 33.8;          // flange spigot, sunk into the rim
spigot_h = 1.2;           // spigot depth into the rim
bore_d = 6.35;            // shaft bore
hub_d = 18.8;             // hub diameter
hub_h = 6;                // hub above the flange
bottom_z = -2;            // lowest point of the pulley
top_z = 17;               // highest point of the pulley

module rim() {
  cylinder(h = belt_w, d = tip_d);
}

module groove_cutter() {
  /* belt tooth groove: deeper than wide, cut through the belt width */
  translate([root_d / 2, 0, 0])
    linear_extrude(height = belt_w)
      polygon(points = [[-0.6, -tooth_w * 0.42], [groove_h + 0.6, -tooth_w * 0.6],
                        [groove_h + 0.6, tooth_w * 0.6], [-0.6, tooth_w * 0.42]]);
}

module flanges() {
  translate([0, 0, -flange_t]) cylinder(h = flange_t, d = flange_d);
  translate([0, 0, belt_w]) cylinder(h = flange_t, d = flange_d);
  translate([0, 0, -spigot_h]) cylinder(h = spigot_h + 0.6, d = spigot_d);
  translate([0, 0, belt_w - 0.6]) cylinder(h = spigot_h + 0.6, d = spigot_d);
}

module hub() {
  translate([0, 0, bottom_z]) cylinder(h = top_z - bottom_z, d = hub_d);
}

difference() {
  union() {
    rim();
    hub();
    flanges();
  }
  for (i = [0 : teeth - 1]) rotate([0, 0, i * 360 / teeth]) groove_cutter();
  translate([0, 0, bottom_z - 1]) cylinder(h = top_z - bottom_z + 2, d = bore_d);
}
