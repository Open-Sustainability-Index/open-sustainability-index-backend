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
          base_year: string | null
          commitment_deadline: string | null
          commitment_type: string | null
          company_name: string
          company_temperature_alignment: string | null
          date_published: string | null
          full_target_language: string | null
          lei: string | null
          reason_for_commitment_extension_or_removal: string | null
          scope: string | null
          status: string | null
          "sub-type": string | null
          target: string | null
          target_classification: string | null
          target_value: string | null
          target_wording: string | null
          target_year: string | null
          type: string | null
          year_type: string | null
        }
        Insert: {
          action?: string | null
          base_year?: string | null
          commitment_deadline?: string | null
          commitment_type?: string | null
          company_name: string
          company_temperature_alignment?: string | null
          date_published?: string | null
          full_target_language?: string | null
          lei?: string | null
          reason_for_commitment_extension_or_removal?: string | null
          scope?: string | null
          status?: string | null
          "sub-type"?: string | null
          target?: string | null
          target_classification?: string | null
          target_value?: string | null
          target_wording?: string | null
          target_year?: string | null
          type?: string | null
          year_type?: string | null
        }
        Update: {
          action?: string | null
          base_year?: string | null
          commitment_deadline?: string | null
          commitment_type?: string | null
          company_name?: string
          company_temperature_alignment?: string | null
          date_published?: string | null
          full_target_language?: string | null
          lei?: string | null
          reason_for_commitment_extension_or_removal?: string | null
          scope?: string | null
          status?: string | null
          "sub-type"?: string | null
          target?: string | null
          target_classification?: string | null
          target_value?: string | null
          target_wording?: string | null
          target_year?: string | null
          type?: string | null
          year_type?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "commitment_company_name_fkey"
            columns: ["company_name"]
            isOneToOne: true
            referencedRelation: "company"
            referencedColumns: ["name"]
          },
          {
            foreignKeyName: "commitment_company_name_fkey"
            columns: ["company_name"]
            isOneToOne: true
            referencedRelation: "company_slug"
            referencedColumns: ["company_name"]
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
          net_zero_year: string | null
          sbt_near_term_target: string | null
          sbt_near_term_year: string | null
          sbt_status: string | null
          source_reports_page: string | null
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
          net_zero_year?: string | null
          sbt_near_term_target?: string | null
          sbt_near_term_year?: string | null
          sbt_status?: string | null
          source_reports_page?: string | null
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
          net_zero_year?: string | null
          sbt_near_term_target?: string | null
          sbt_near_term_year?: string | null
          sbt_status?: string | null
          source_reports_page?: string | null
          updated_at?: string
        }
        Relationships: []
      }
      emission: {
        Row: {
          all_cats: string | null
          cat_1: string | null
          cat_10: string | null
          cat_11: string | null
          cat_12: string | null
          cat_13: string | null
          cat_14: string | null
          cat_15: string | null
          cat_2: string | null
          cat_3: string | null
          cat_4: string | null
          cat_5: string | null
          cat_6: string | null
          cat_7: string | null
          cat_8: string | null
          cat_9: string | null
          comment: string | null
          company_name: string
          cradle_to_gate: number | null
          currency: string | null
          emission_intensity: number | null
          emission_page: string | null
          fiscal_year: string | null
          ghg_standard: string | null
          hq_country_move: string | null
          industry: string | null
          isic_rev_4: string | null
          page_revenue: string | null
          publication_date: string | null
          revenue: number | null
          revenue_million: number | null
          scope_1: number | null
          scope_1_share_of_total_upstream_emissions: string | null
          scope_2_location_based: string | null
          scope_2_market_based: string | null
          scope_2_unknown: string | null
          share_upstream_of_scope_3: string | null
          source: string | null
          source_emisions_page_move: string | null
          source_emission_link: string | null
          source_emission_report: string | null
          source_revenue: string | null
          source_revenue_link: string | null
          status: string | null
          total_emission_location_based: string | null
          total_emission_market_based: string | null
          total_reported_emission_scope_1_2: number | null
          total_reported_emission_scope_1_2_3: number | null
          total_scope_3: string | null
          total_upstream_emissions: number | null
          upstream_scope_3: string | null
          year: number
        }
        Insert: {
          all_cats?: string | null
          cat_1?: string | null
          cat_10?: string | null
          cat_11?: string | null
          cat_12?: string | null
          cat_13?: string | null
          cat_14?: string | null
          cat_15?: string | null
          cat_2?: string | null
          cat_3?: string | null
          cat_4?: string | null
          cat_5?: string | null
          cat_6?: string | null
          cat_7?: string | null
          cat_8?: string | null
          cat_9?: string | null
          comment?: string | null
          company_name: string
          cradle_to_gate?: number | null
          currency?: string | null
          emission_intensity?: number | null
          emission_page?: string | null
          fiscal_year?: string | null
          ghg_standard?: string | null
          hq_country_move?: string | null
          industry?: string | null
          isic_rev_4?: string | null
          page_revenue?: string | null
          publication_date?: string | null
          revenue?: number | null
          revenue_million?: number | null
          scope_1?: number | null
          scope_1_share_of_total_upstream_emissions?: string | null
          scope_2_location_based?: string | null
          scope_2_market_based?: string | null
          scope_2_unknown?: string | null
          share_upstream_of_scope_3?: string | null
          source?: string | null
          source_emisions_page_move?: string | null
          source_emission_link?: string | null
          source_emission_report?: string | null
          source_revenue?: string | null
          source_revenue_link?: string | null
          status?: string | null
          total_emission_location_based?: string | null
          total_emission_market_based?: string | null
          total_reported_emission_scope_1_2?: number | null
          total_reported_emission_scope_1_2_3?: number | null
          total_scope_3?: string | null
          total_upstream_emissions?: number | null
          upstream_scope_3?: string | null
          year: number
        }
        Update: {
          all_cats?: string | null
          cat_1?: string | null
          cat_10?: string | null
          cat_11?: string | null
          cat_12?: string | null
          cat_13?: string | null
          cat_14?: string | null
          cat_15?: string | null
          cat_2?: string | null
          cat_3?: string | null
          cat_4?: string | null
          cat_5?: string | null
          cat_6?: string | null
          cat_7?: string | null
          cat_8?: string | null
          cat_9?: string | null
          comment?: string | null
          company_name?: string
          cradle_to_gate?: number | null
          currency?: string | null
          emission_intensity?: number | null
          emission_page?: string | null
          fiscal_year?: string | null
          ghg_standard?: string | null
          hq_country_move?: string | null
          industry?: string | null
          isic_rev_4?: string | null
          page_revenue?: string | null
          publication_date?: string | null
          revenue?: number | null
          revenue_million?: number | null
          scope_1?: number | null
          scope_1_share_of_total_upstream_emissions?: string | null
          scope_2_location_based?: string | null
          scope_2_market_based?: string | null
          scope_2_unknown?: string | null
          share_upstream_of_scope_3?: string | null
          source?: string | null
          source_emisions_page_move?: string | null
          source_emission_link?: string | null
          source_emission_report?: string | null
          source_revenue?: string | null
          source_revenue_link?: string | null
          status?: string | null
          total_emission_location_based?: string | null
          total_emission_market_based?: string | null
          total_reported_emission_scope_1_2?: number | null
          total_reported_emission_scope_1_2_3?: number | null
          total_scope_3?: string | null
          total_upstream_emissions?: number | null
          upstream_scope_3?: string | null
          year?: number
        }
        Relationships: [
          {
            foreignKeyName: "emission_company_name_fkey"
            columns: ["company_name"]
            isOneToOne: false
            referencedRelation: "company"
            referencedColumns: ["name"]
          },
          {
            foreignKeyName: "emission_company_name_fkey"
            columns: ["company_name"]
            isOneToOne: false
            referencedRelation: "company_slug"
            referencedColumns: ["company_name"]
          },
        ]
      }
      target: {
        Row: {
          action: string | null
          base_year: number | null
          commitment_deadline: string | null
          commitment_type: string | null
          company_name: string
          company_temperature_alignment: string | null
          date_published: string | null
          full_target_language: string | null
          lei: string | null
          reason_for_commitment_extension_or_removal: string | null
          scope: string
          status: string | null
          "sub-type": string | null
          target: string | null
          target_classification: string | null
          target_value: string | null
          target_wording: string | null
          target_year: number
          type: string
          year_type: string | null
        }
        Insert: {
          action?: string | null
          base_year?: number | null
          commitment_deadline?: string | null
          commitment_type?: string | null
          company_name: string
          company_temperature_alignment?: string | null
          date_published?: string | null
          full_target_language?: string | null
          lei?: string | null
          reason_for_commitment_extension_or_removal?: string | null
          scope: string
          status?: string | null
          "sub-type"?: string | null
          target?: string | null
          target_classification?: string | null
          target_value?: string | null
          target_wording?: string | null
          target_year: number
          type: string
          year_type?: string | null
        }
        Update: {
          action?: string | null
          base_year?: number | null
          commitment_deadline?: string | null
          commitment_type?: string | null
          company_name?: string
          company_temperature_alignment?: string | null
          date_published?: string | null
          full_target_language?: string | null
          lei?: string | null
          reason_for_commitment_extension_or_removal?: string | null
          scope?: string
          status?: string | null
          "sub-type"?: string | null
          target?: string | null
          target_classification?: string | null
          target_value?: string | null
          target_wording?: string | null
          target_year?: number
          type?: string
          year_type?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "target_company_name_fkey"
            columns: ["company_name"]
            isOneToOne: false
            referencedRelation: "company"
            referencedColumns: ["name"]
          },
          {
            foreignKeyName: "target_company_name_fkey"
            columns: ["company_name"]
            isOneToOne: false
            referencedRelation: "company_slug"
            referencedColumns: ["company_name"]
          },
        ]
      }
      temp_company: {
        Row: {
          autogenerated_contact: string | null
          company_url: string | null
          hq_country: string | null
          industry: string | null
          isic: string | null
          name: string | null
          net_zero_year: string | null
          sbt_near_term_target: string | null
          sbt_near_term_year: string | null
          sbt_status: string | null
          source_reports_page: string | null
          sustainability_contact_email: string | null
          sustainability_contact_linkedin: string | null
          sustainability_contact_name: string | null
        }
        Insert: {
          autogenerated_contact?: string | null
          company_url?: string | null
          hq_country?: string | null
          industry?: string | null
          isic?: string | null
          name?: string | null
          net_zero_year?: string | null
          sbt_near_term_target?: string | null
          sbt_near_term_year?: string | null
          sbt_status?: string | null
          source_reports_page?: string | null
          sustainability_contact_email?: string | null
          sustainability_contact_linkedin?: string | null
          sustainability_contact_name?: string | null
        }
        Update: {
          autogenerated_contact?: string | null
          company_url?: string | null
          hq_country?: string | null
          industry?: string | null
          isic?: string | null
          name?: string | null
          net_zero_year?: string | null
          sbt_near_term_target?: string | null
          sbt_near_term_year?: string | null
          sbt_status?: string | null
          source_reports_page?: string | null
          sustainability_contact_email?: string | null
          sustainability_contact_linkedin?: string | null
          sustainability_contact_name?: string | null
        }
        Relationships: []
      }
    }
    Views: {
      companies_by_intensity: {
        Row: {
          all_cats: string | null
          cat_1: string | null
          cat_10: string | null
          cat_11: string | null
          cat_12: string | null
          cat_13: string | null
          cat_14: string | null
          cat_15: string | null
          cat_2: string | null
          cat_3: string | null
          cat_4: string | null
          cat_5: string | null
          cat_6: string | null
          cat_7: string | null
          cat_8: string | null
          cat_9: string | null
          comment: string | null
          company_name: string | null
          cradle_to_gate: number | null
          currency: string | null
          emission_intensity: number | null
          emission_page: string | null
          fiscal_year: string | null
          ghg_standard: string | null
          hq_country_move: string | null
          industry: string | null
          isic_rev_4: string | null
          page_revenue: string | null
          publication_date: string | null
          revenue: number | null
          revenue_million: number | null
          scope_1: number | null
          scope_1_share_of_total_upstream_emissions: string | null
          scope_2_location_based: string | null
          scope_2_market_based: string | null
          scope_2_unknown: string | null
          share_upstream_of_scope_3: string | null
          source: string | null
          source_emisions_page_move: string | null
          source_emission_link: string | null
          source_emission_report: string | null
          source_revenue: string | null
          source_revenue_link: string | null
          status: string | null
          total_emission_location_based: string | null
          total_emission_market_based: string | null
          total_reported_emission_scope_1_2: number | null
          total_reported_emission_scope_1_2_3: number | null
          total_scope_3: string | null
          total_upstream_emissions: number | null
          upstream_scope_3: string | null
          year: number | null
        }
        Insert: {
          all_cats?: string | null
          cat_1?: string | null
          cat_10?: string | null
          cat_11?: string | null
          cat_12?: string | null
          cat_13?: string | null
          cat_14?: string | null
          cat_15?: string | null
          cat_2?: string | null
          cat_3?: string | null
          cat_4?: string | null
          cat_5?: string | null
          cat_6?: string | null
          cat_7?: string | null
          cat_8?: string | null
          cat_9?: string | null
          comment?: string | null
          company_name?: string | null
          cradle_to_gate?: number | null
          currency?: string | null
          emission_intensity?: number | null
          emission_page?: string | null
          fiscal_year?: string | null
          ghg_standard?: string | null
          hq_country_move?: string | null
          industry?: string | null
          isic_rev_4?: string | null
          page_revenue?: string | null
          publication_date?: string | null
          revenue?: number | null
          revenue_million?: number | null
          scope_1?: number | null
          scope_1_share_of_total_upstream_emissions?: string | null
          scope_2_location_based?: string | null
          scope_2_market_based?: string | null
          scope_2_unknown?: string | null
          share_upstream_of_scope_3?: string | null
          source?: string | null
          source_emisions_page_move?: string | null
          source_emission_link?: string | null
          source_emission_report?: string | null
          source_revenue?: string | null
          source_revenue_link?: string | null
          status?: string | null
          total_emission_location_based?: string | null
          total_emission_market_based?: string | null
          total_reported_emission_scope_1_2?: number | null
          total_reported_emission_scope_1_2_3?: number | null
          total_scope_3?: string | null
          total_upstream_emissions?: number | null
          upstream_scope_3?: string | null
          year?: number | null
        }
        Update: {
          all_cats?: string | null
          cat_1?: string | null
          cat_10?: string | null
          cat_11?: string | null
          cat_12?: string | null
          cat_13?: string | null
          cat_14?: string | null
          cat_15?: string | null
          cat_2?: string | null
          cat_3?: string | null
          cat_4?: string | null
          cat_5?: string | null
          cat_6?: string | null
          cat_7?: string | null
          cat_8?: string | null
          cat_9?: string | null
          comment?: string | null
          company_name?: string | null
          cradle_to_gate?: number | null
          currency?: string | null
          emission_intensity?: number | null
          emission_page?: string | null
          fiscal_year?: string | null
          ghg_standard?: string | null
          hq_country_move?: string | null
          industry?: string | null
          isic_rev_4?: string | null
          page_revenue?: string | null
          publication_date?: string | null
          revenue?: number | null
          revenue_million?: number | null
          scope_1?: number | null
          scope_1_share_of_total_upstream_emissions?: string | null
          scope_2_location_based?: string | null
          scope_2_market_based?: string | null
          scope_2_unknown?: string | null
          share_upstream_of_scope_3?: string | null
          source?: string | null
          source_emisions_page_move?: string | null
          source_emission_link?: string | null
          source_emission_report?: string | null
          source_revenue?: string | null
          source_revenue_link?: string | null
          status?: string | null
          total_emission_location_based?: string | null
          total_emission_market_based?: string | null
          total_reported_emission_scope_1_2?: number | null
          total_reported_emission_scope_1_2_3?: number | null
          total_scope_3?: string | null
          total_upstream_emissions?: number | null
          upstream_scope_3?: string | null
          year?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "emission_company_name_fkey"
            columns: ["company_name"]
            isOneToOne: false
            referencedRelation: "company"
            referencedColumns: ["name"]
          },
          {
            foreignKeyName: "emission_company_name_fkey"
            columns: ["company_name"]
            isOneToOne: false
            referencedRelation: "company_slug"
            referencedColumns: ["company_name"]
          },
        ]
      }
      company_slug: {
        Row: {
          company_name: string | null
          company_url: string | null
          industry: string | null
          isic: string | null
          lei: string | null
          net_zero_year: string | null
          sbt_near_term_target: string | null
          sbt_near_term_year: string | null
          sbt_status: string | null
          slug: string | null
          source_reports_page: string | null
        }
        Insert: {
          company_name?: string | null
          company_url?: string | null
          industry?: string | null
          isic?: string | null
          lei?: string | null
          net_zero_year?: string | null
          sbt_near_term_target?: string | null
          sbt_near_term_year?: string | null
          sbt_status?: string | null
          slug?: never
          source_reports_page?: string | null
        }
        Update: {
          company_name?: string | null
          company_url?: string | null
          industry?: string | null
          isic?: string | null
          lei?: string | null
          net_zero_year?: string | null
          sbt_near_term_target?: string | null
          sbt_near_term_year?: string | null
          sbt_status?: string | null
          slug?: never
          source_reports_page?: string | null
        }
        Relationships: []
      }
      industry: {
        Row: {
          company_count: number | null
          name: string | null
          slug: string | null
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
          industry: string
          commitment_type: string
          status: string
          commitment_deadline: string
          total_reported_emission_scope_1_2_3: number
          revenue: number
          hq_country_move: string
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
          industry: string
          lei: string
          company_url: string
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

