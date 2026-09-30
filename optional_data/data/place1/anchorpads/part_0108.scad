$fn = 32;

// ----------------------------------------------------------------------
// Anchor pads 120 x 60 x 22
// four corner bosses with anchor holes
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate = [120, 60, 12];  // base plate size (x, y, z)
pads = 4;               // boss count, one per corner
edge = 14;              // boss centre offset from the plate edge
boss_d = 22;            // boss diameter
boss_h = 10;            // boss height above the base plate
hole_d = 6.6;           // hole diameter

// --- derived feature positions (mm) ---
height = plate[2] + boss_h;      // = 22   overall height of the part
corner_x = plate[0] / 2 - edge;  // = 46   boss centre X
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
