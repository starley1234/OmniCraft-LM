$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 14, 12 mm, 65 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 15;                // step 4 length
total = 65;               // overall length
chamfer = 2.5;            // end chamfer
groove_r = 6;             // groove radius
groove_z = 52;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1.6;           // groove depth
key_w = 8;                // keyway width
key_d = 4;                // keyway depth
key_len = 24;             // keyway length
key_z = 38;               // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 30], [15, 30], [15, 40], [7, 40], [7, 50], [6, 50], [6, 62.5], [3.5, 65], [0, 65]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
