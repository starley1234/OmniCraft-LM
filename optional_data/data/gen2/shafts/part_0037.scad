$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 14, 10, 8 mm, 85 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 14;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 10;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 8;                   // step 3 diameter
len3 = 30;                // step 3 length
total = 85;               // overall length
chamfer = 1.12;           // end chamfer
key_w = 4;                // keyway width
key_d = 2;                // keyway depth
key_len = 24;             // keyway length
key_z = 58;               // keyway start along the shaft
cross_d = 5;              // cross pin hole
cross_z = 70;             // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [7 - chamfer, 0], [7, chamfer], [7, 30], [5, 30], [5, 55], [4, 55], [4, 83.88], [2.88, 85], [0, 85]];

difference() {
  rotate_extrude() polygon(profile);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 4, d = cross_d, center = true);
}
