$fn = 32;

// ----------------------------------------------------------------------
// Rib frame 150 x 80 x 14
// 4 ribs at 30 mm pitch, staggered
// ----------------------------------------------------------------------

// --- parameters (mm) ---
frame = [150, 80, 4];  // base plate size (x, y, z)
rail_w = 10;           // side rail width
ribs = 4;              // number of ribs
rib_t = 5;             // rib thickness
rib_h = 10;            // rib height above the base plate
pitch = 30;            // pitch between rib centres

// --- derived feature positions (mm) ---
span = (ribs - 1) * pitch;          // = 90   distance between the outer ribs
origin_x = -span / 2;               // = -45   X of the first rib
rib_len = frame[1] / 2 - rail_w + 0.5;  // = 30.5   length of a staggered rib
rib_y = 0.5 + rib_len / 2;          // = 15.75   Y of a staggered rib centre
row_offset = 2 * rib_y;             // = 31.5   distance between the two rows
feature_centers = [
  [origin_x + 0 * pitch, rib_y],
  [origin_x + 1 * pitch, -rib_y],
  [origin_x + 2 * pitch, rib_y],
  [origin_x + 3 * pitch, -rib_y]
];   // rib centre line, drives the rib loop

// base plate, two side rails, then the ribs read straight off feature_centers
union() {
  translate([-frame[0] / 2, -frame[1] / 2, 0]) cube(frame);
  translate([-frame[0] / 2, -frame[1] / 2, 0]) cube([frame[0], rail_w, frame[2] + rib_h]);
  translate([-frame[0] / 2, frame[1] / 2 - rail_w, 0]) cube([frame[0], rail_w, frame[2] + rib_h]);
  for (centre = feature_centers)
    translate([centre[0] - rib_t / 2, centre[1] - rib_len / 2, frame[2] - 1])
      cube([rib_t, rib_len, rib_h + 1]);
}
