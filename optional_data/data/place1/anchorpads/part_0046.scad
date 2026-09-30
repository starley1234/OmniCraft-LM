$fn = 32;

// ----------------------------------------------------------------------
// Anchor pads 120 x 64 x 12
// four corner bosses with anchor holes
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate = [120, 64, 6];  // base plate size (x, y, z)
pads = 4;              // boss count, one per corner
edge = 16;             // boss centre offset from the plate edge
boss_d = 26;           // boss diameter
boss_h = 6;            // boss height above the base plate
hole_d = 8.4;          // hole diameter

// --- derived feature positions (mm) ---
height = plate[2] + boss_h;      // = 12   overall height of the part
corner_x = plate[0] / 2 - edge;  // = 44   boss centre X
corner_y = plate[1] / 2 - edge;  // = 16   boss centre Y
feature_centers = [
  [corner_x, corner_y],
  [-corner_x, corner_y],
  [-corner_x, -corner_y],
  [corner_x, -corner_y]
];   // boss centres, anchor holes are drilled there

// base plate, four bosses standing on it, anchor holes all the way through
difference() {
  union() {
    cube(plate, center = true);
    for (centre = feature_centers)
      translate([centre[0], centre[1], plate[2] / 2 - 1])
        cylinder(d = boss_d, h = boss_h + 1);
  }
  for (centre = feature_centers)
    translate([centre[0], centre[1], -height])
      cylinder(d = hole_d, h = 2 * height + 2);  // through boss and plate
}
