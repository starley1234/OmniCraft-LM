$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 25, 12 mm, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 15;                // step 3 length
total = 50;               // overall length
chamfer = 1.5;            // end chamfer
key_w = 5;                // keyway width
key_d = 2.5;              // keyway depth
key_len = 19;             // keyway length
key_z = 28;               // keyway start along the shaft
cross_d = 4;              // cross pin hole
cross_z = 42.5;           // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 25], [12.5, 25], [12.5, 35], [6, 35], [6, 48.5], [4.5, 50], [0, 50]];

difference() {
  rotate_extrude() polygon(profile);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 4, d = cross_d, center = true);
}
