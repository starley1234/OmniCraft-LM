$fn = 32;

// ----------------------------------------------------------------------
// Vent box: roundvent enclosure
// ----------------------------------------------------------------------

// --- parameters (mm) ---
box_l = 100;              // box length, X
box_w = 80;               // box width, Y
box_h = 50;               // box height, Z
wall_t = 2;               // shell wall thickness
vent_d = 24;              // central vent diameter
ring_d = 5;               // ring hole diameter
n_ring = 8;               // holes in the ring
ring_r = 17.5;            // ring radius

ring_step = 360 / n_ring;  // ring hole angular step

difference() {
  cube([box_l, box_w, box_h]);
  translate([wall_t, wall_t, wall_t])
    cube([box_l - 2 * wall_t, box_w - 2 * wall_t, box_h]);
  translate([box_l / 2, box_w - wall_t - 1, box_h / 2])
    rotate([-90, 0, 0]) cylinder(h = wall_t + 2, d = vent_d);
  for (i = [0 : n_ring - 1])
    translate([box_l / 2, box_w - wall_t - 1, box_h / 2])
      rotate([0, 0, i * ring_step])
        translate([ring_r, 0, 0]) rotate([-90, 0, 0])
          cylinder(h = wall_t + 2, d = ring_d);
}
