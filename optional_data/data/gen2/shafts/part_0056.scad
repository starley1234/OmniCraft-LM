$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 40, 8 mm, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 40;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 8;                   // step 3 diameter
len3 = 30;                // step 3 length
total = 70;               // overall length
chamfer = 2;              // end chamfer
groove_r = 20;            // groove radius
groove_z = 17;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 1.6;           // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 15], [20, 15], [20, 40], [4, 40], [4, 68], [2, 70], [0, 70]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
