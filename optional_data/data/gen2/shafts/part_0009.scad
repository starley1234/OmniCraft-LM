$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 14, 12, 8 mm, 115 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 20;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 30;                // step 4 length
d5 = 8;                   // step 5 diameter
len5 = 15;                // step 5 length
total = 115;              // overall length
chamfer = 2.5;            // end chamfer
groove_r = 6;             // groove radius
groove_z = 72;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.6;           // groove depth
key_w = 8;                // keyway width
key_d = 4;                // keyway depth
key_len = 24;             // keyway length
key_z = 88;               // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 30], [15, 30], [15, 50], [7, 50], [7, 70], [6, 70], [6, 100], [4, 100], [4, 112.5], [1.5, 115], [0, 115]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
