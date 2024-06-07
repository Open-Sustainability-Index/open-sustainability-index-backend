export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      commitment: {
        Row: {
          action: string | null
          commitment_deadline: string | null
          commitment_type: string
          company_slug: string
          created_at: string | null
          date_published: string | null
          reason_for_commitment_extension_or_removal: string | null
          status: string | null
          updated_at: string | null
          year_type: string | null
        }
        Insert: {
          action?: string | null
          commitment_deadline?: string | null
          commitment_type: string
          company_slug: string
          created_at?: string | null
          date_published?: string | null
          reason_for_commitment_extension_or_removal?: string | null
          status?: string | null
          updated_at?: string | null
          year_type?: string | null
        }
        Update: {
          action?: string | null
          commitment_deadline?: string | null
          commitment_type?: string
          company_slug?: string
          created_at?: string | null
          date_published?: string | null
          reason_for_commitment_extension_or_removal?: string | null
          status?: string | null
          updated_at?: string | null
          year_type?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "public_commitment_company_slug_fkey"
            columns: ["company_slug"]
            isOneToOne: false
            referencedRelation: "company"
            referencedColumns: ["slug"]
          },
          {
            foreignKeyName: "public_commitment_company_slug_fkey"
            columns: ["company_slug"]
            isOneToOne: false
            referencedRelation: "view_company_slug"
            referencedColumns: ["slug"]
          },
        ]
      }
      company: {
        Row: {
          company_url: string | null
          created_at: string
          hq_country: string | null
          id: string
          industry: string | null
          isic: string | null
          lei: string | null
          name: string
          slug: string | null
          updated_at: string
        }
        Insert: {
          company_url?: string | null
          created_at?: string
          hq_country?: string | null
          id?: string
          industry?: string | null
          isic?: string | null
          lei?: string | null
          name: string
          slug?: string | null
          updated_at?: string
        }
        Update: {
          company_url?: string | null
          created_at?: string
          hq_country?: string | null
          id?: string
          industry?: string | null
          isic?: string | null
          lei?: string | null
          name?: string
          slug?: string | null
          updated_at?: string
        }
        Relationships: []
      }
      emission: {
        Row: {
          all_cats: string | null
          cat_1: number | null
          cat_10: number | null
          cat_11: number | null
          cat_12: number | null
          cat_13: number | null
          cat_14: number | null
          cat_15: number | null
          cat_2: number | null
          cat_3: number | null
          cat_4: number | null
          cat_5: number | null
          cat_6: number | null
          cat_7: number | null
          cat_8: number | null
          cat_9: number | null
          company_slug: string
          cradle_to_gate: number | null
          created_at: string | null
          currency: string | null
          emission_intensity: number | null
          emission_page: string | null
          fiscal_year: string | null
          ghg_standard: string | null
          page_revenue: string | null
          publication_date: string | null
          revenue: number | null
          revenue_million: number | null
          scope_1: number | null
          scope_1_share_of_total_upstream_emissions: number | null
          scope_2_location_based: number | null
          scope_2_market_based: number | null
          scope_2_unknown: number | null
          share_upstream_of_scope_3: number | null
          source_emission_link: string | null
          source_emission_report: string | null
          source_emissions_page_move: string | null
          source_revenue: string | null
          source_revenue_link: string | null
          status: string | null
          total_emission_location_based: number | null
          total_emission_market_based: number | null
          total_reported_emission_scope_1_2: number | null
          total_reported_emission_scope_1_2_3: number | null
          total_scope_3: number | null
          total_upstream_emissions: number | null
          updated_at: string | null
          upstream_scope_3: number | null
          year: number
        }
        Insert: {
          all_cats?: string | null
          cat_1?: number | null
          cat_10?: number | null
          cat_11?: number | null
          cat_12?: number | null
          cat_13?: number | null
          cat_14?: number | null
          cat_15?: number | null
          cat_2?: number | null
          cat_3?: number | null
          cat_4?: number | null
          cat_5?: number | null
          cat_6?: number | null
          cat_7?: number | null
          cat_8?: number | null
          cat_9?: number | null
          company_slug: string
          cradle_to_gate?: number | null
          created_at?: string | null
          currency?: string | null
          emission_intensity?: number | null
          emission_page?: string | null
          fiscal_year?: string | null
          ghg_standard?: string | null
          page_revenue?: string | null
          publication_date?: string | null
          revenue?: number | null
          revenue_million?: number | null
          scope_1?: number | null
          scope_1_share_of_total_upstream_emissions?: number | null
          scope_2_location_based?: number | null
          scope_2_market_based?: number | null
          scope_2_unknown?: number | null
          share_upstream_of_scope_3?: number | null
          source_emission_link?: string | null
          source_emission_report?: string | null
          source_emissions_page_move?: string | null
          source_revenue?: string | null
          source_revenue_link?: string | null
          status?: string | null
          total_emission_location_based?: number | null
          total_emission_market_based?: number | null
          total_reported_emission_scope_1_2?: number | null
          total_reported_emission_scope_1_2_3?: number | null
          total_scope_3?: number | null
          total_upstream_emissions?: number | null
          updated_at?: string | null
          upstream_scope_3?: number | null
          year: number
        }
        Update: {
          all_cats?: string | null
          cat_1?: number | null
          cat_10?: number | null
          cat_11?: number | null
          cat_12?: number | null
          cat_13?: number | null
          cat_14?: number | null
          cat_15?: number | null
          cat_2?: number | null
          cat_3?: number | null
          cat_4?: number | null
          cat_5?: number | null
          cat_6?: number | null
          cat_7?: number | null
          cat_8?: number | null
          cat_9?: number | null
          company_slug?: string
          cradle_to_gate?: number | null
          created_at?: string | null
          currency?: string | null
          emission_intensity?: number | null
          emission_page?: string | null
          fiscal_year?: string | null
          ghg_standard?: string | null
          page_revenue?: string | null
          publication_date?: string | null
          revenue?: number | null
          revenue_million?: number | null
          scope_1?: number | null
          scope_1_share_of_total_upstream_emissions?: number | null
          scope_2_location_based?: number | null
          scope_2_market_based?: number | null
          scope_2_unknown?: number | null
          share_upstream_of_scope_3?: number | null
          source_emission_link?: string | null
          source_emission_report?: string | null
          source_emissions_page_move?: string | null
          source_revenue?: string | null
          source_revenue_link?: string | null
          status?: string | null
          total_emission_location_based?: number | null
          total_emission_market_based?: number | null
          total_reported_emission_scope_1_2?: number | null
          total_reported_emission_scope_1_2_3?: number | null
          total_scope_3?: number | null
          total_upstream_emissions?: number | null
          updated_at?: string | null
          upstream_scope_3?: number | null
          year?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_emission_slug_fkey"
            columns: ["company_slug"]
            isOneToOne: false
            referencedRelation: "company"
            referencedColumns: ["slug"]
          },
          {
            foreignKeyName: "public_emission_slug_fkey"
            columns: ["company_slug"]
            isOneToOne: false
            referencedRelation: "view_company_slug"
            referencedColumns: ["slug"]
          },
        ]
      }
      target: {
        Row: {
          action: string | null
          base_year: number | null
          company_slug: string
          company_temperature_alignment: string | null
          created_at: string | null
          date_published: string | null
          full_target_language: string | null
          scope: string
          sub_type: string | null
          target: string | null
          target_classification: string | null
          target_value: number | null
          target_wording: string
          target_year: number
          type: string
          updated_at: string | null
          year_type: string | null
        }
        Insert: {
          action?: string | null
          base_year?: number | null
          company_slug: string
          company_temperature_alignment?: string | null
          created_at?: string | null
          date_published?: string | null
          full_target_language?: string | null
          scope: string
          sub_type?: string | null
          target?: string | null
          target_classification?: string | null
          target_value?: number | null
          target_wording: string
          target_year: number
          type: string
          updated_at?: string | null
          year_type?: string | null
        }
        Update: {
          action?: string | null
          base_year?: number | null
          company_slug?: string
          company_temperature_alignment?: string | null
          created_at?: string | null
          date_published?: string | null
          full_target_language?: string | null
          scope?: string
          sub_type?: string | null
          target?: string | null
          target_classification?: string | null
          target_value?: number | null
          target_wording?: string
          target_year?: number
          type?: string
          updated_at?: string | null
          year_type?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "public_target_company_slug_fkey"
            columns: ["company_slug"]
            isOneToOne: false
            referencedRelation: "company"
            referencedColumns: ["slug"]
          },
          {
            foreignKeyName: "public_target_company_slug_fkey"
            columns: ["company_slug"]
            isOneToOne: false
            referencedRelation: "view_company_slug"
            referencedColumns: ["slug"]
          },
        ]
      }
    }
    Views: {
      industry: {
        Row: {
          company_count: number | null
          name: string | null
          slug: string | null
        }
        Relationships: []
      }
      view_company_slug: {
        Row: {
          company_name: string | null
          company_url: string | null
          industry: string | null
          isic: string | null
          lei: string | null
          name: string | null
          slug: string | null
          slug_old: string | null
        }
        Insert: {
          company_name?: string | null
          company_url?: string | null
          industry?: string | null
          isic?: string | null
          lei?: string | null
          name?: string | null
          slug?: string | null
          slug_old?: never
        }
        Update: {
          company_name?: string | null
          company_url?: string | null
          industry?: string | null
          isic?: string | null
          lei?: string | null
          name?: string | null
          slug?: string | null
          slug_old?: never
        }
        Relationships: []
      }
    }
    Functions: {
      companies: {
        Args: {
          offset_value: number
          limit_value: number
          sort_by: string
          sort_order: string
          industry_filter?: string
          near_term_filter?: boolean
          commitment_type_filter?: string
          commitment_status_filter?: string
          target_target_filter?: string
        }
        Returns: {
          company_name: string
          slug: string
          company_url: string
          industry: string
          commitment_type: string
          status: string
          commitment_deadline: string
          total_reported_emission_scope_1_2_3: number
          revenue: number
          hq_country: string
          year: number
          currency: string
          emission_intensity: number
          targets: Database["public"]["CompositeTypes"]["target_info"][]
        }[]
      }
      companies_v2: {
        Args: {
          offset_value: number
          limit_value: number
          sort_by: string
          sort_order: string
          industry_filter?: string
          near_term_filter?: boolean
          commitment_type_filter?: string
          commitment_status_filter?: string
          target_target_filter?: string
          emissions_required?: string
        }
        Returns: {
          company_name: string
          slug: string
          company_url: string
          industry: string
          lei: string
          updated_at: string
          id: string
          commitments: Json[]
          emissions: Json[]
          targets: Database["public"]["CompositeTypes"]["target_info"][]
        }[]
      }
      search: {
        Args: {
          query: string
          sort_by?: string
          sort_order?: string
        }
        Returns: {
          name: string
          slug: string
          type: string
        }[]
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      target_info: {
        target_type: string | null
        target_scope: string | null
        target_year: number | null
        target: string | null
      }
    }
  }
}

type PublicSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  PublicTableNameOrOptions extends
    | keyof (PublicSchema["Tables"] & PublicSchema["Views"])
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
        Database[PublicTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
      Database[PublicTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : PublicTableNameOrOptions extends keyof (PublicSchema["Tables"] &
        PublicSchema["Views"])
    ? (PublicSchema["Tables"] &
        PublicSchema["Views"])[PublicTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  PublicEnumNameOrOptions extends
    | keyof PublicSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = PublicEnumNameOrOptions extends { schema: keyof Database }
  ? Database[PublicEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : PublicEnumNameOrOptions extends keyof PublicSchema["Enums"]
    ? PublicSchema["Enums"][PublicEnumNameOrOptions]
    : never

