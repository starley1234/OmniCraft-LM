$fn = 32;

// ----------------------------------------------------------------------
// Anchor pads 180 x 84 x 20
// four corner bosses with anchor holes
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate = [180, 84, 12];  // base plate size (x, y, z)
pads = 4;               // boss count, one per corner
edge = 21;              // boss centre offset from the plate edge
boss_d = 36;            // boss diameter
boss_h = 8;             // boss height above the base plate
hole_d = 5.5;           // hole diameter

// --- derived feature positions (mm) ---
height = plate[2] + boss_h;      // = 20   overall height of the part
corner_x = plate[0] / 2 - edge;  // = 69   boss centre X
corner_y = plate[1] / 2 - edge;  // = 21   boss centre Y
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
