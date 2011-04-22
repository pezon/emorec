/**
 *  @file
 *  @author Adam Vaughn
 */

#include <stdint.h>

/**
 *  @def MAGIC_CONSTANT
 *
 *  This magic constant is used to improve the precision of some operations.
 *  The larger the better, although if it is too large, calculations may
 *  overflow, causing bad results. For the sake of saving clock cycles on
 *   multiplication, this should generally be a power of two.
 */
#define MAGIC_CONSTANT 2048

/**
 *  @def HIST_LEN
 *
 *  The length of a histogram.
 */
#define HIST_LEN (UINT8_MAX + 1)

/**
 *  @enum RETURN_CODE
 *
 *  Return codes used for error checking.
 */
enum RETURN_CODE
{
  SUCCESS,
  OUT_OF_BOUNDS,
  MALLOC
};

/**
 *  Calculate a histogram of the different LBPs in an image.
 *
 *  @param i The image to use.
 *  @param h The height of the image.
 *  @param w The width of the image.
 *  @param h A location at which to store the histogram.
 *  @return @see RETURN_CODE
 */
int gen_histogram (uint8_t const *const image, const uint32_t h,
		   const uint32_t w, uint8_t ** const histogram);

/**
 *  Get the local binary pattern of a pixel in an image.
 *
 *  While calculating the local binary pattern, edges of the image are
 *  considered pixels of value zero. The image is assumed to be stored
 *  line-by-line from the top left to bottom right.
 *
 *  @param x The horizontal position of the pixel to inspect.
 *  @param y The vertical position of the pixel to inspect.
 *  @param image The image to inspect.
 *  @param h The height of the image.
 *  @param w The width of the image.
 *  @param lbp A location to store the local binary pattern.
 *  @return @see RETURN_CODE
 */
int calc_lbp (const uint32_t x, const uint32_t y, uint8_t const *const image,
	      const uint32_t h, const uint32_t w, uint8_t * const lbp);

/**
 *  Normalize an array of unsigned 32-bit integers to an array of unsigned
 *  8-bit integers.
 *
 *  @param in The input array.
 *  @param n The length of the array.
 *  @param out A location for the output array.
 *  @return @see RETURN_CODE
 */
int norm (uint32_t const *const in, const uint32_t n, uint8_t ** const out);

/**
 *  Calculate the test statistic.
 *
 *  Compare an observed frequency distribution to an expected frequency
 *  distribution. The result of the calculation is the chi-squared statistic
 *  scaled by MAGIC_CONSTANT. @see MAGIC_CONSTANT
 *
 *  @param o The observed frequency distribution.
 *  @param e The expected frequency distribution.
 *  @param l The length of the frequency distributions.
 *  @param s A location to store the test statistic.
 *  @return @see RETURN_CODE
 */
int calc_stat (uint8_t const *const o, uint8_t const *const e, const uint32_t l,
	       uint32_t * const s);

/**
 *  Get a percentile from a statistic.
 *
 *  @param t The test statistic.
 *  @param p A location to store the percentile.
 *  @return @see RETURN_CODE
 */
int calc_p (const uint32_t t, uint32_t * const p);

/**
 *  Calculate the probability that the given image is related to the given
 *  eigenface.
 *
 *  @param image The image under inspection.
 *  @param h The height of the image.
 *  @param w The width of the image.
 *  @param eigenface The eigenface. Must be 256 elements.
 *  @param p A location to store the percentile.
 *  @return @see RETURN_CODE
 */
int test_match(uint8_t const *const image, const uint32_t h, const uint32_t w, uint8_t const *const eigenface, uint32_t * const p);

int free_histogram(uint8_t *const histogram);

