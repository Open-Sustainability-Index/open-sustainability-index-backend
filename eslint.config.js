import eslint from '@eslint/js';
import tseslint from 'typescript-eslint';
import eslintPluginPrettierRecommended from 'eslint-plugin-prettier/recommended';

export default tseslint.config(
  eslint.configs.recommended,
  ...tseslint.configs.recommendedTypeChecked,
  ...tseslint.configs.stylisticTypeChecked,
  {
    languageOptions: {
      parserOptions: {
        project: true,
        tsconfigRootDir: import.meta.dirname,
      },
    },
  },
  {
    files: ['*.js', '*.mjs', 'app/types/supabase/index.d.ts'],
    ...tseslint.configs.disableTypeChecked,
  },
  {
    ignores: ['supabase/*'],
  },
  eslintPluginPrettierRecommended,
);
