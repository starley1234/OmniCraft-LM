$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 16, 10, 8 mm, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 15;                // step 4 length
total = 70;               // overall length
chamfer = 2;              // end chamfer
key_w = 5;                // keyway width
key_d = 2.5;              // keyway depth
key_len = 24;             // keyway length
key_z = 43;               // keyway start along the shaft
cross_d = 5;              // cross pin hole
cross_z = 62.5;           // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 30], [8, 30], [8, 45], [5, 45], [5, 55], [4, 55], [4, 68], [2, 70], [0, 70]];

difference() {
  rotate_extrude() polygon(profile);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
