$fn = 32;
// ----------------------------------------------------------------------
// G-code: round hub with 5 bolt holes
// ----------------------------------------------------------------------
// --- parameters (mm) ---
base_d = 96;            // outer diameter of the hub
base_t = 10;            // base thickness
hole_d = 6;             // bolt hole diameter
hole_n = 5;             // number of bolt holes
spoke = 12;             // number of spokes
spoke_t = 3.5;          // spoke thickness
spoke_h = 10;           // spoke height
spoke_bore = 2.5;       // bore through the spoke
module hub() {
  /* round hub with a raised rim */
  cylinder(h = base_t + spoke_h, d = base_d);
}
module spoke() {
  /* spoke as a trapeze: larger diameter at the rim, smaller in the middle */
  translate([0, 0, base_t - 1])
    linear_extrude(height = spoke_h + 1)
      polygon(points = [[25, 0], [25, spoke_h], [20.25, spoke_h - 1]]);
}
module spokes() {
  for (i = [0 : spoke - 1])
    rotate([0, i * 360 / spoke]) spoke();
}
// --- overall assembly ---
union() {
  hub();
  spokes();
}
